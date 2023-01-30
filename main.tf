data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  workspace_id = var.create_workspace ? try(aws_grafana_workspace.this[0].id, null) : var.workspace_id
}

################################################################################
# Workspace
################################################################################

resource "aws_grafana_workspace" "this" {
  count = var.create && var.create_workspace ? 1 : 0

  name        = var.name
  description = var.description

  account_access_type      = var.account_access_type
  authentication_providers = var.authentication_providers
  permission_type          = var.permission_type

  data_sources              = var.data_sources
  notification_destinations = var.notification_destinations
  organization_role_name    = var.organization_role_name
  organizational_units      = var.organizational_units
  role_arn                  = var.create_iam_role ? aws_iam_role.this[0].arn : var.iam_role_arn
  stack_set_name            = coalesce(var.stack_set_name, var.name)

  dynamic "vpc_configuration" {
    for_each = length(var.vpc_configuration) > 0 ? [var.vpc_configuration] : []

    content {
      security_group_ids = var.create_security_group ? concat([aws_security_group.this[0].id], vpc_configuration.value.security_group_ids) : vpc_configuration.value.security_group_ids
      subnet_ids         = vpc_configuration.value.subnet_ids
    }
  }

  tags = var.tags
}

################################################################################
# Security Group
################################################################################

locals {
  create_security_group = length(var.vpc_configuration) > 0 && var.create_security_group
  security_group_name   = try(coalesce(var.security_group_name, var.name), "")
}

data "aws_subnet" "this" {
  count = local.create_security_group ? 1 : 0

  id = element(var.vpc_configuration.subnet_ids, 0)
}

resource "aws_security_group" "this" {
  count = local.create_security_group ? 1 : 0

  name        = var.security_group_use_name_prefix ? null : local.security_group_name
  name_prefix = var.security_group_use_name_prefix ? "${local.security_group_name}-" : null
  description = var.security_group_description
  vpc_id      = data.aws_subnet.this[0].vpc_id

  tags = merge(var.tags, var.security_group_tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v if local.create_security_group }

  # Required
  security_group_id = aws_security_group.this[0].id
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  type              = each.value.type

  # Optional
  description              = lookup(each.value, "description", null)
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  ipv6_cidr_blocks         = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(each.value, "prefix_list_ids", null)
  self                     = lookup(each.value, "self", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}

################################################################################
# Workspace API Key
################################################################################

resource "aws_grafana_workspace_api_key" "this" {
  for_each = { for k, v in var.workspace_api_keys : k => v if var.create }

  key_name        = try(each.value.key_name, each.key)
  key_role        = each.value.key_role
  seconds_to_live = each.value.seconds_to_live
  workspace_id    = local.workspace_id
}

################################################################################
# Workspace IAM Role
################################################################################

locals {
  create_role   = var.create && var.create_iam_role
  iam_role_name = coalesce(var.iam_role_name, var.name)

  create_account_policy = local.create_role && var.account_access_type == "CURRENT_ACCOUNT"
  create_custom_policy  = length(setintersection(var.data_sources, ["CLOUDWATCH", "AMAZON_OPENSEARCH_SERVICE", "PROMETHEUS", "SNS"])) > 0
}

data "aws_iam_policy_document" "assume" {
  count = local.create_role ? 1 : 0

  statement {
    sid     = "GrafanaAssume"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["grafana.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_iam_role" "this" {
  count = local.create_role ? 1 : 0

  name        = var.use_iam_role_name_prefix ? null : local.iam_role_name
  name_prefix = var.use_iam_role_name_prefix ? "${local.iam_role_name}-" : null
  description = var.iam_role_description
  path        = var.iam_role_path

  assume_role_policy    = data.aws_iam_policy_document.assume[0].json
  force_detach_policies = var.iam_role_force_detach_policies
  max_session_duration  = var.iam_role_max_session_duration
  permissions_boundary  = var.iam_role_permissions_boundary

  tags = merge(var.tags, var.iam_role_tags)
}

resource "aws_iam_role_policy_attachment" "additional" {
  for_each = { for k, v in var.iam_role_policy_arns : k => v if local.create_role }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

# https://docs.aws.amazon.com/grafana/latest/userguide/AMG-manage-permissions.html
data "aws_iam_policy_document" "this" {
  count = local.create_account_policy ? 1 : 0

  # CloudWatch
  dynamic "statement" {
    for_each = contains(var.data_sources, "CLOUDWATCH") ? [1] : []

    content {
      sid = "AllowReadingMetricsFromCloudWatch"
      actions = [
        "cloudwatch:DescribeAlarmsForMetric",
        "cloudwatch:DescribeAlarmHistory",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:GetMetricData",
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = contains(var.data_sources, "CLOUDWATCH") ? [1] : []

    content {
      sid = "AllowReadingLogsFromCloudWatch"
      actions = [
        "logs:DescribeLogGroups",
        "logs:GetLogGroupFields",
        "logs:StartQuery",
        "logs:StopQuery",
        "logs:GetQueryResults",
        "logs:GetLogEvents",
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = contains(var.data_sources, "CLOUDWATCH") ? [1] : []

    content {
      sid = "AllowReadingTagsInstancesRegionsFromEC2"
      actions = [
        "ec2:DescribeTags",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = contains(var.data_sources, "CLOUDWATCH") ? [1] : []

    content {
      sid = "AllowReadingResourcesForTags"
      actions = [
        "tag:GetResources",
      ]
      resources = ["*"]
    }
  }

  # OpenSearch
  dynamic "statement" {
    for_each = contains(var.data_sources, "AMAZON_OPENSEARCH_SERVICE") ? [1] : []

    content {
      actions = [
        "es:ESHttpGet",
        "es:DescribeElasticsearchDomains",
        "es:ListDomainNames",
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = contains(var.data_sources, "AMAZON_OPENSEARCH_SERVICE") ? [1] : []

    content {
      actions = [
        "es:ESHttpPost",
      ]
      resources = [
        "arn:${data.aws_partition.current.partition}:es:*:*:domain/*/_msearch*",
        "arn:${data.aws_partition.current.partition}:es:*:*:domain/*/_opendistro/_ppl",
      ]
    }
  }

  # Prometheus
  dynamic "statement" {
    for_each = contains(var.data_sources, "PROMETHEUS") ? [1] : []

    content {
      actions = [
        "aps:ListWorkspaces",
        "aps:DescribeWorkspace",
        "aps:QueryMetrics",
        "aps:GetLabels",
        "aps:GetSeries",
        "aps:GetMetricMetadata",
      ]
      resources = ["*"]
    }
  }

  # SNS Notification
  dynamic "statement" {
    for_each = contains(var.notification_destinations, "SNS") ? [1] : []

    content {
      actions = [
        "sns:Publish",
      ]
      resources = ["arn:${data.aws_partition.current.partition}:sns:*:${data.aws_caller_identity.current.account_id}:grafana*"]
    }
  }
}

resource "aws_iam_policy" "this" {
  count = local.create_account_policy && local.create_custom_policy ? 1 : 0

  name_prefix = "${local.iam_role_name}-"
  description = var.iam_role_description
  path        = var.iam_role_path
  policy      = data.aws_iam_policy_document.this[0].json

  tags = var.tags
}

locals {
  policies_to_attach = {
    this = {
      arn    = try(aws_iam_policy.this[0].arn, null)
      attach = local.create_custom_policy
    }
    sitewise = {
      arn    = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AWSIoTSiteWiseReadOnlyAccess"
      attach = contains(var.data_sources, "SITEWISE")
    }
    redshift = {
      arn    = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonGrafanaRedshiftAccess"
      attach = contains(var.data_sources, "REDSHIFT")
    }
    athena = {
      arn    = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonGrafanaAthenaAccess"
      attach = contains(var.data_sources, "ATHENA")
    }
    timestream = {
      arn    = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonTimestreamReadOnlyAccess"
      attach = contains(var.data_sources, "TIMESTREAM")
    }
    xray = {
      arn    = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AWSXrayReadOnlyAccess"
      attach = contains(var.data_sources, "XRAY")
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in local.policies_to_attach : k => v if local.create_account_policy && v.attach }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value.arn
}

################################################################################
# Workspace SAML Configuration
################################################################################

resource "aws_grafana_workspace_saml_configuration" "this" {
  count = var.create && contains(var.authentication_providers, "SAML") ? 1 : 0

  editor_role_values = var.saml_editor_role_values
  workspace_id       = local.workspace_id

  idp_metadata_url = var.saml_idp_metadata_url
  idp_metadata_xml = var.saml_idp_metadata_xml

  admin_role_values       = var.saml_admin_role_values
  allowed_organizations   = var.saml_allowed_organizations
  email_assertion         = var.saml_email_assertion
  groups_assertion        = var.saml_groups_assertion
  login_assertion         = var.saml_login_assertion
  login_validity_duration = var.saml_login_validity_duration
  name_assertion          = var.saml_name_assertion
  org_assertion           = var.saml_org_assertion
  role_assertion          = var.saml_role_assertion
}

################################################################################
# License Association
################################################################################

resource "aws_grafana_license_association" "this" {
  count = var.create && var.associate_license ? 1 : 0

  license_type = var.license_type
  workspace_id = local.workspace_id
}

################################################################################
# Role Association
################################################################################

resource "aws_grafana_role_association" "this" {
  for_each = { for k, v in var.role_associations : k => v if var.create }

  role         = try(each.value.role, each.key)
  group_ids    = try(each.value.group_ids, null)
  user_ids     = try(each.value.user_ids, null)
  workspace_id = local.workspace_id
}
