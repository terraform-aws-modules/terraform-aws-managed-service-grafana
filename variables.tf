variable "create" {
  description = "Determines whether a resources will be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Workspace
################################################################################

variable "create_workspace" {
  description = "Determines whether a workspace will be created or to use an existing workspace"
  type        = bool
  default     = true
}

variable "workspace_id" {
  description = "The ID of an existing workspace to use when `create_workspace` is `false`"
  type        = string
  default     = ""
}

variable "name" {
  description = "The Grafana workspace name. Required if stack_set_name is not provided. Valid special characters include "-", ".", "_", “~”. Cannot contain non-ASCII characters or spaces. Max length of 255 characters."
  type        = string
  default     = null
}

variable "description" {
  description = "The workspace description"
  type        = string
  default     = null
}

variable "account_access_type" {
  description = "The type of account access for the workspace. Valid values are `CURRENT_ACCOUNT` and `ORGANIZATION`"
  type        = string
  default     = "CURRENT_ACCOUNT"
}

variable "authentication_providers" {
  description = "The authentication providers for the workspace. Valid values are `AWS_SSO`, `SAML`, or both"
  type        = list(string)
  default     = ["AWS_SSO"]
}

variable "permission_type" {
  description = "The permission type of the workspace. If `SERVICE_MANAGED` is specified, the IAM roles and IAM policy attachments are generated automatically. If `CUSTOMER_MANAGED` is specified, the IAM roles and IAM policy attachments will not be created"
  type        = string
  default     = "SERVICE_MANAGED"
}

variable "data_sources" {
  description = "The data sources for the workspace. Valid values are `AMAZON_OPENSEARCH_SERVICE`, `ATHENA`, `CLOUDWATCH`, `PROMETHEUS`, `REDSHIFT`, `SITEWISE`, `TIMESTREAM`, `XRAY`"
  type        = list(string)
  default     = []
}

variable "notification_destinations" {
  description = "The notification destinations. If a data source is specified here, Amazon Managed Grafana will create IAM roles and permissions needed to use these destinations. Must be set to `SNS`"
  type        = list(string)
  default     = []
}

variable "organization_role_name" {
  description = "The role name that the workspace uses to access resources through Amazon Organizations"
  type        = string
  default     = null
}

variable "organizational_units" {
  description = "The Amazon Organizations organizational units that the workspace is authorized to use data sources from"
  type        = list(string)
  default     = []
}

variable "stack_set_name" {
  description = "The AWS CloudFormation stack set name that provisions IAM roles to be used by the workspace. Required if name is not provided. Valid special characters include "-", ".", "_", “~”. Cannot contain non-ASCII characters or spaces. Max length of 255 characters."
  type        = string
  default     = null
}

################################################################################
# Workspace API Key
################################################################################

variable "workspace_api_keys" {
  description = "Map of workspace API key definitions to create"
  type        = any
  default     = {}
}

################################################################################
# Workspace IAM Role
################################################################################

variable "create_iam_role" {
  description = "Determines whether a an IAM role is created or to use an existing IAM role"
  type        = bool
  default     = true
}

variable "iam_role_arn" {
  description = "Existing IAM role ARN for the workspace. Required if `create_iam_role` is set to `false`"
  type        = string
  default     = null
}

variable "iam_role_name" {
  description = "Name to use on workspace IAM role created"
  type        = string
  default     = null
}

variable "use_iam_role_name_prefix" {
  description = "Determines whether the IAM role name (`wokspace_iam_role_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "iam_role_description" {
  description = "The description of the workspace IAM role"
  type        = string
  default     = null
}

variable "iam_role_path" {
  description = "Workspace IAM role path"
  type        = string
  default     = null
}

variable "iam_role_force_detach_policies" {
  description = "Determines whether the workspace IAM role policies will be forced to detach"
  type        = bool
  default     = true
}

variable "iam_role_max_session_duration" {
  description = "Maximum session duration (in seconds) that you want to set for the IAM role"
  type        = number
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "iam_role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to the workspace IAM role"
  type        = list(string)
  default     = []
}

variable "iam_role_tags" {
  description = "A map of additional tags to add to the IAM role created"
  type        = map(string)
  default     = {}
}

################################################################################
# Workspace SAML Configuration
################################################################################

variable "saml_editor_role_values" {
  description = "SAML authentication editor role values"
  type        = list(string)
  default     = []
}

variable "saml_idp_metadata_url" {
  description = "SAML authentication IDP Metadata URL. Note that either `saml_idp_metadata_url` or `saml_idp_metadata_xml`"
  type        = string
  default     = null
}

variable "saml_idp_metadata_xml" {
  description = "SAML authentication IDP Metadata XML. Note that either `saml_idp_metadata_url` or `saml_idp_metadata_xml`"
  type        = string
  default     = null
}

variable "saml_admin_role_values" {
  description = "SAML authentication admin role values"
  type        = list(string)
  default     = []
}

variable "saml_allowed_organizations" {
  description = "SAML authentication allowed organizations"
  type        = list(string)
  default     = []
}

variable "saml_email_assertion" {
  description = "SAML authentication email assertion"
  type        = string
  default     = null
}

variable "saml_groups_assertion" {
  description = "SAML authentication groups assertion"
  type        = string
  default     = null
}

variable "saml_login_assertion" {
  description = "SAML authentication email assertion"
  type        = string
  default     = null
}

variable "saml_login_validity_duration" {
  description = "SAML authentication login validity duration"
  type        = number
  default     = null
}

variable "saml_name_assertion" {
  description = "SAML authentication name assertion"
  type        = string
  default     = null
}

variable "saml_org_assertion" {
  description = "SAML authentication org assertion"
  type        = string
  default     = null
}

variable "saml_role_assertion" {
  description = "SAML authentication role assertion"
  type        = string
  default     = null
}

################################################################################
# License Association
################################################################################

variable "associate_license" {
  description = "Determines whether a license will be associated with the workspace. Use false if you do not have an active enterprise license in the AWS Marketplace."
  type        = bool
  default     = true
}

variable "license_type" {
  description = "The type of license for the workspace license association. Valid values are `ENTERPRISE` and `ENTERPRISE_FREE_TRIAL`"
  type        = string
  default     = "ENTERPRISE"
}

################################################################################
# Role Association
################################################################################

variable "role_associations" {
  description = "Map of maps to assocaite user/group IDs to a role. Map key can be used as the `role`"
  type        = any
  default     = {}
}
