provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region      = "us-east-1"
  name        = "amg-ex-${replace(basename(path.cwd), "_", "-")}"
  description = "AWS Managed Grafana service for ${local.name}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-manage-service-grafana"
    GithubOrg  = "terraform-aws-modules"
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
  grafana_version           = "10.4"

  configuration = jsonencode({
    unifiedAlerting = {
      enabled = true
    },
    plugins = {
      pluginAdminEnabled = false
    }
  })

  # vpc configuration
  vpc_configuration = {
    subnet_ids = module.vpc.private_subnets
  }
  security_group_rules = {
    egress_postgresql = {
      description = "Allow egress to PostgreSQL"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
  }

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

  # Workspace service accounts
  workspace_service_accounts = {
    viewer = {
      grafana_role = "VIEWER"
    }
    editor = {
      name         = "editor-example"
      grafana_role = "EDITOR"
    }
    admin = {
      grafana_role = "ADMIN"
    }
  }

  workspace_service_account_tokens = {
    viewer = {
      service_account_key = "viewer"
      seconds_to_live     = 3600
    }
    editor = {
      name                = "editor-example"
      service_account_key = "editor"
      seconds_to_live     = 3600
    }
    admin = {
      service_account_key = "admin"
      seconds_to_live     = 3600
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

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  enable_nat_gateway = false # disabling for example, re-evaluate for your environment
  single_nat_gateway = true

  tags = local.tags
}
