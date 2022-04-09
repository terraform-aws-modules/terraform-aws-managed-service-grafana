data "aws_partition" "current" {}

################################################################################
# Workspace
################################################################################

resource "aws_grafana_workspace" "this" {
  count = var.create ? 1 : 0

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
}
# No-op to trigger release
################################################################################
# Workspace IAM Role
################################################################################

locals {
  iam_role_name = coalesce(var.iam_role_name, var.name)
}

data "aws_iam_policy_document" "assume" {
  count = var.create && var.create_iam_role ? 1 : 0

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
  count = var.create && var.create_iam_role ? 1 : 0

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

################################################################################
# Workspace SAML Configuration
################################################################################

resource "aws_grafana_workspace_saml_configuration" "this" {
  count = var.create && contains(var.authentication_providers, "SAML") ? 1 : 0

  editor_role_values = var.saml_editor_role_values
  workspace_id       = aws_grafana_workspace.this[0].id

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
  workspace_id = aws_grafana_workspace.this[0].id
}

################################################################################
# Role Association
################################################################################

resource "aws_grafana_role_association" "this" {
  for_each = { for k, v in var.role_associations : k => v if var.create }

  role         = try(each.value.role, each.key)
  group_ids    = try(each.value.group_ids, null)
  user_ids     = try(each.value.user_ids, null)
  workspace_id = aws_grafana_workspace.this[0].id
}
