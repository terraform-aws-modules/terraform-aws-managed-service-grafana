# AWS Managed Service for Grafana (AMG) Terraform module

Terraform module which creates AWS Managed Service for Grafana (AMG) resources.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

See [`examples`](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/tree/main/examples) directory for working examples to reference:

```hcl
module "managed_grafana" {
  source = "terraform-aws-modules/managed-service-grafana/aws"

  # Workspace
  name                      = "example"
  description               = "AWS Managed Grafana service example workspace"
  account_access_type       = "CURRENT_ACCOUNT"
  authentication_providers  = ["AWS_SSO"]
  permission_type           = "SERVICE_MANAGED"
  data_sources              = ["CLOUDWATCH", "PROMETHEUS", "XRAY"]
  notification_destinations = ["SNS"]

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

  # Workspace SAML configuration
  saml_admin_role_values  = ["admin"]
  saml_editor_role_values = ["editor"]
  saml_email_assertion    = "mail"
  saml_groups_assertion   = "groups"
  saml_login_assertion    = "mail"
  saml_name_assertion     = "displayName"
  saml_org_assertion      = "org"
  saml_role_assertion     = "role"
  saml_idp_metadata_url   = "https://my_idp_metadata.url"

  # Role associations
  role_associations = {
    "ADMIN" = {
      "group_ids" = ["1111111111-abcdefgh-1234-5678-abcd-999999999999"]
    }
    "EDITOR" = {
      "user_ids" = ["2222222222-abcdefgh-1234-5678-abcd-999999999999"]
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/tree/main/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/tree/main/examples/complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.51 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.51 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_grafana_license_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_license_association) | resource |
| [aws_grafana_role_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_role_association) | resource |
| [aws_grafana_workspace.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_workspace) | resource |
| [aws_grafana_workspace_api_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_workspace_api_key) | resource |
| [aws_grafana_workspace_saml_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_workspace_saml_configuration) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_access_type"></a> [account\_access\_type](#input\_account\_access\_type) | The type of account access for the workspace. Valid values are `CURRENT_ACCOUNT` and `ORGANIZATION` | `string` | `"CURRENT_ACCOUNT"` | no |
| <a name="input_associate_license"></a> [associate\_license](#input\_associate\_license) | Determines whether a license will be associated with the workspace | `bool` | `true` | no |
| <a name="input_authentication_providers"></a> [authentication\_providers](#input\_authentication\_providers) | The authentication providers for the workspace. Valid values are `AWS_SSO`, `SAML`, or both | `list(string)` | <pre>[<br>  "AWS_SSO"<br>]</pre> | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether a resources will be created | `bool` | `true` | no |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Determines whether a an IAM role is created or to use an existing IAM role | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines if a security group is created | `bool` | `true` | no |
| <a name="input_create_workspace"></a> [create\_workspace](#input\_create\_workspace) | Determines whether a workspace will be created or to use an existing workspace | `bool` | `true` | no |
| <a name="input_data_sources"></a> [data\_sources](#input\_data\_sources) | The data sources for the workspace. Valid values are `AMAZON_OPENSEARCH_SERVICE`, `ATHENA`, `CLOUDWATCH`, `PROMETHEUS`, `REDSHIFT`, `SITEWISE`, `TIMESTREAM`, `XRAY` | `list(string)` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The workspace description | `string` | `null` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | Existing IAM role ARN for the workspace. Required if `create_iam_role` is set to `false` | `string` | `null` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | The description of the workspace IAM role | `string` | `null` | no |
| <a name="input_iam_role_force_detach_policies"></a> [iam\_role\_force\_detach\_policies](#input\_iam\_role\_force\_detach\_policies) | Determines whether the workspace IAM role policies will be forced to detach | `bool` | `true` | no |
| <a name="input_iam_role_max_session_duration"></a> [iam\_role\_max\_session\_duration](#input\_iam\_role\_max\_session\_duration) | Maximum session duration (in seconds) that you want to set for the IAM role | `number` | `null` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name to use on workspace IAM role created | `string` | `null` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | Workspace IAM role path | `string` | `null` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_iam_role_policy_arns"></a> [iam\_role\_policy\_arns](#input\_iam\_role\_policy\_arns) | List of ARNs of IAM policies to attach to the workspace IAM role | `list(string)` | `[]` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | A map of additional tags to add to the IAM role created | `map(string)` | `{}` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | The type of license for the workspace license association. Valid values are `ENTERPRISE` and `ENTERPRISE_FREE_TRIAL` | `string` | `"ENTERPRISE"` | no |
| <a name="input_name"></a> [name](#input\_name) | The Grafana workspace name | `string` | `null` | no |
| <a name="input_notification_destinations"></a> [notification\_destinations](#input\_notification\_destinations) | The notification destinations. If a data source is specified here, Amazon Managed Grafana will create IAM roles and permissions needed to use these destinations. Must be set to `SNS` | `list(string)` | `[]` | no |
| <a name="input_organization_role_name"></a> [organization\_role\_name](#input\_organization\_role\_name) | The role name that the workspace uses to access resources through Amazon Organizations | `string` | `null` | no |
| <a name="input_organizational_units"></a> [organizational\_units](#input\_organizational\_units) | The Amazon Organizations organizational units that the workspace is authorized to use data sources from | `list(string)` | `[]` | no |
| <a name="input_permission_type"></a> [permission\_type](#input\_permission\_type) | The permission type of the workspace. If `SERVICE_MANAGED` is specified, the IAM roles and IAM policy attachments are generated automatically. If `CUSTOMER_MANAGED` is specified, the IAM roles and IAM policy attachments will not be created | `string` | `"SERVICE_MANAGED"` | no |
| <a name="input_role_associations"></a> [role\_associations](#input\_role\_associations) | Map of maps to assocaite user/group IDs to a role. Map key can be used as the `role` | `any` | `{}` | no |
| <a name="input_saml_admin_role_values"></a> [saml\_admin\_role\_values](#input\_saml\_admin\_role\_values) | SAML authentication admin role values | `list(string)` | `[]` | no |
| <a name="input_saml_allowed_organizations"></a> [saml\_allowed\_organizations](#input\_saml\_allowed\_organizations) | SAML authentication allowed organizations | `list(string)` | `[]` | no |
| <a name="input_saml_editor_role_values"></a> [saml\_editor\_role\_values](#input\_saml\_editor\_role\_values) | SAML authentication editor role values | `list(string)` | `[]` | no |
| <a name="input_saml_email_assertion"></a> [saml\_email\_assertion](#input\_saml\_email\_assertion) | SAML authentication email assertion | `string` | `null` | no |
| <a name="input_saml_groups_assertion"></a> [saml\_groups\_assertion](#input\_saml\_groups\_assertion) | SAML authentication groups assertion | `string` | `null` | no |
| <a name="input_saml_idp_metadata_url"></a> [saml\_idp\_metadata\_url](#input\_saml\_idp\_metadata\_url) | SAML authentication IDP Metadata URL. Note that either `saml_idp_metadata_url` or `saml_idp_metadata_xml` | `string` | `null` | no |
| <a name="input_saml_idp_metadata_xml"></a> [saml\_idp\_metadata\_xml](#input\_saml\_idp\_metadata\_xml) | SAML authentication IDP Metadata XML. Note that either `saml_idp_metadata_url` or `saml_idp_metadata_xml` | `string` | `null` | no |
| <a name="input_saml_login_assertion"></a> [saml\_login\_assertion](#input\_saml\_login\_assertion) | SAML authentication email assertion | `string` | `null` | no |
| <a name="input_saml_login_validity_duration"></a> [saml\_login\_validity\_duration](#input\_saml\_login\_validity\_duration) | SAML authentication login validity duration | `number` | `null` | no |
| <a name="input_saml_name_assertion"></a> [saml\_name\_assertion](#input\_saml\_name\_assertion) | SAML authentication name assertion | `string` | `null` | no |
| <a name="input_saml_org_assertion"></a> [saml\_org\_assertion](#input\_saml\_org\_assertion) | SAML authentication org assertion | `string` | `null` | no |
| <a name="input_saml_role_assertion"></a> [saml\_role\_assertion](#input\_saml\_role\_assertion) | SAML authentication role assertion | `string` | `null` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | Description of the security group created | `string` | `null` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name to use on security group created | `string` | `null` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | Security group rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | A map of additional tags to add to the security group created | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_stack_set_name"></a> [stack\_set\_name](#input\_stack\_set\_name) | The AWS CloudFormation stack set name that provisions IAM roles to be used by the workspace | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_use_iam_role_name_prefix"></a> [use\_iam\_role\_name\_prefix](#input\_use\_iam\_role\_name\_prefix) | Determines whether the IAM role name (`wokspace_iam_role_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_vpc_configuration"></a> [vpc\_configuration](#input\_vpc\_configuration) | The configuration settings for an Amazon VPC that contains data sources for your Grafana workspace to connect to | `any` | `{}` | no |
| <a name="input_workspace_api_keys"></a> [workspace\_api\_keys](#input\_workspace\_api\_keys) | Map of workspace API key definitions to create | `any` | `{}` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | The ID of an existing workspace to use when `create_workspace` is `false` | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_license_expiration"></a> [license\_expiration](#output\_license\_expiration) | If `license_type` is set to `ENTERPRISE`, this is the expiration date of the enterprise license |
| <a name="output_license_free_trial_expiration"></a> [license\_free\_trial\_expiration](#output\_license\_free\_trial\_expiration) | If `license_type` is set to `ENTERPRISE_FREE_TRIAL`, this is the expiration date of the free trial |
| <a name="output_saml_configuration_status"></a> [saml\_configuration\_status](#output\_saml\_configuration\_status) | Status of the SAML configuration |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
| <a name="output_workspace_api_keys"></a> [workspace\_api\_keys](#output\_workspace\_api\_keys) | The workspace API keys created including their attributes |
| <a name="output_workspace_arn"></a> [workspace\_arn](#output\_workspace\_arn) | The Amazon Resource Name (ARN) of the Grafana workspace |
| <a name="output_workspace_endpoint"></a> [workspace\_endpoint](#output\_workspace\_endpoint) | The endpoint of the Grafana workspace |
| <a name="output_workspace_grafana_version"></a> [workspace\_grafana\_version](#output\_workspace\_grafana\_version) | The version of Grafana running on the workspace |
| <a name="output_workspace_iam_role_arn"></a> [workspace\_iam\_role\_arn](#output\_workspace\_iam\_role\_arn) | IAM role ARN of the Grafana workspace |
| <a name="output_workspace_iam_role_name"></a> [workspace\_iam\_role\_name](#output\_workspace\_iam\_role\_name) | IAM role name of the Grafana workspace |
| <a name="output_workspace_iam_role_unique_id"></a> [workspace\_iam\_role\_unique\_id](#output\_workspace\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The ID of the Grafana workspace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/blob/main/LICENSE).
