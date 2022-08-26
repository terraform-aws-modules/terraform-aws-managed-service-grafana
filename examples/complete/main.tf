provider "aws" {
  region = local.region
}

locals {
  region      = "us-east-1"
  name        = "amg-ex-${replace(basename(path.cwd), "_", "-")}"
  description = "AWS Managed Grafana service for ${local.name}"

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana"
  }
}

################################################################################
# Managed Grafana Module
################################################################################

module "managed_grafana" {
  source = "../.."

  # Workspace
  name                      = local.name
  associate_license         = false
  description               = local.description
  account_access_type       = "CURRENT_ACCOUNT"
  authentication_providers  = ["AWS_SSO"]
  permission_type           = "SERVICE_MANAGED"
  data_sources              = ["CLOUDWATCH", "PROMETHEUS", "XRAY"]
  notification_destinations = ["SNS"]
  stack_set_name            = local.name

  # Workspace API keys
  workspace_api_keys = {
    viewer = {
      key_name        = "viewer"
      key_role        = "VIEWER"
      seconds_to_live = 3600
    }
    editor = {
      key_name        = "editor"
      key_role        = "EDITOR"
      seconds_to_live = 3600
    }
    admin = {
      key_name        = "admin"
      key_role        = "ADMIN"
      seconds_to_live = 3600
    }
  }

  # Workspace IAM role
  create_iam_role                = true
  iam_role_name                  = local.name
  use_iam_role_name_prefix       = true
  iam_role_description           = local.description
  iam_role_path                  = "/grafana/"
  iam_role_force_detach_policies = true
  iam_role_max_session_duration  = 7200
  iam_role_tags                  = { role = true }

  # # Workspace SAML configuration
  # saml_admin_role_values  = ["admin"]
  # saml_editor_role_values = ["editor"]
  # saml_email_assertion    = "mail"
  # saml_groups_assertion   = "groups"
  # saml_login_assertion    = "mail"
  # saml_name_assertion     = "displayName"
  # saml_org_assertion      = "org"
  # saml_role_assertion     = "role"
  # saml_idp_metadata_url   = "https://my_idp_metadata.url"

  # Role associations
  # Ref: https://github.com/aws/aws-sdk/issues/25
  # Ref: https://github.com/hashicorp/terraform-provider-aws/issues/18812
  # WARNING: https://github.com/hashicorp/terraform-provider-aws/issues/24166
  # role_associations = {
  #   "ADMIN" = {
  #     "group_ids" = ["1111111111-abcdefgh-1234-5678-abcd-999999999999"]
  #   }
  #   "EDITOR" = {
  #     "user_ids" = ["2222222222-abcdefgh-1234-5678-abcd-999999999999"]
  #   }
  # }

  tags = local.tags
}

module "managed_grafana_default" {
  source = "../.."

  name              = "${local.name}-default"
  associate_license = false

  tags = local.tags
}

module "managed_grafana_disabled" {
  source = "../.."

  name   = local.name
  create = false
}
