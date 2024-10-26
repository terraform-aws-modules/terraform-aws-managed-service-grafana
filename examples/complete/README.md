# Complete AWS Managed Service for Grafana (AMG) Example

Configuration in this directory creates:

- Disabled Grafana workspace
- Default Grafana workspace (using defaults provided by the module)
- Complete Grafana workspace showing example of possible configurations

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.59 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.59 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_managed_grafana"></a> [managed\_grafana](#module\_managed\_grafana) | ../.. | n/a |
| <a name="module_managed_grafana_disabled"></a> [managed\_grafana\_disabled](#module\_managed\_grafana\_disabled) | ../.. | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_license_expiration"></a> [license\_expiration](#output\_license\_expiration) | If `license_type` is set to `ENTERPRISE`, this is the expiration date of the enterprise license |
| <a name="output_license_free_trial_expiration"></a> [license\_free\_trial\_expiration](#output\_license\_free\_trial\_expiration) | If `license_type` is set to `ENTERPRISE_FREE_TRIAL`, this is the expiration date of the free trial |
| <a name="output_saml_configuration_status"></a> [saml\_configuration\_status](#output\_saml\_configuration\_status) | Status of the SAML configuration |
| <a name="output_workspace_api_keys"></a> [workspace\_api\_keys](#output\_workspace\_api\_keys) | The workspace API keys created including their attributes |
| <a name="output_workspace_arn"></a> [workspace\_arn](#output\_workspace\_arn) | The Amazon Resource Name (ARN) of the Grafana workspace |
| <a name="output_workspace_endpoint"></a> [workspace\_endpoint](#output\_workspace\_endpoint) | The endpoint of the Grafana workspace |
| <a name="output_workspace_grafana_version"></a> [workspace\_grafana\_version](#output\_workspace\_grafana\_version) | The version of Grafana running on the workspace |
| <a name="output_workspace_iam_role_arn"></a> [workspace\_iam\_role\_arn](#output\_workspace\_iam\_role\_arn) | IAM role ARN of the Grafana workspace |
| <a name="output_workspace_iam_role_name"></a> [workspace\_iam\_role\_name](#output\_workspace\_iam\_role\_name) | IAM role name of the Grafana workspace |
| <a name="output_workspace_iam_role_policy_arn"></a> [workspace\_iam\_role\_policy\_arn](#output\_workspace\_iam\_role\_policy\_arn) | IAM Policy ARN of the Grafana workspace IAM role |
| <a name="output_workspace_iam_role_policy_id"></a> [workspace\_iam\_role\_policy\_id](#output\_workspace\_iam\_role\_policy\_id) | Stable and unique string identifying the IAM Policy |
| <a name="output_workspace_iam_role_policy_name"></a> [workspace\_iam\_role\_policy\_name](#output\_workspace\_iam\_role\_policy\_name) | IAM Policy name of the Grafana workspace IAM role |
| <a name="output_workspace_iam_role_unique_id"></a> [workspace\_iam\_role\_unique\_id](#output\_workspace\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The ID of the Grafana workspace |
| <a name="output_workspace_service_account_tokens"></a> [workspace\_service\_account\_tokens](#output\_workspace\_service\_account\_tokens) | The workspace service account tokens created including their attributes |
| <a name="output_workspace_service_accounts"></a> [workspace\_service\_accounts](#output\_workspace\_service\_accounts) | The workspace service accounts created including their attributes |
<!-- END_TF_DOCS -->

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/blob/main/LICENSE).
