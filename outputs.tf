################################################################################
# Workspace
################################################################################

output "workspace_arn" {
  description = "The Amazon Resource Name (ARN) of the Grafana workspace"
  value       = try(aws_grafana_workspace.this[0].arn, null)
}

output "workspace_id" {
  description = "The ID of the Grafana workspace"
  value       = try(aws_grafana_workspace.this[0].id, null)
}

output "workspace_endpoint" {
  description = "The endpoint of the Grafana workspace"
  value       = try(aws_grafana_workspace.this[0].endpoint, null)
}

output "workspace_grafana_version" {
  description = "The version of Grafana running on the workspace"
  value       = try(aws_grafana_workspace.this[0].grafana_version, null)
}

################################################################################
# Workspace API Key
################################################################################

output "workspace_api_keys" {
  description = "The workspace API keys created including their attributes"
  value       = aws_grafana_workspace_api_key.this
}

################################################################################
# Workspace IAM Role
################################################################################

output "workspace_iam_role_name" {
  description = "IAM role name of the Grafana workspace"
  value       = try(aws_iam_role.this[0].name, null)
}

output "workspace_iam_role_arn" {
  description = "IAM role ARN of the Grafana workspace"
  value       = try(aws_iam_role.this[0].arn, null)
}

output "workspace_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = try(aws_iam_role.this[0].unique_id, null)
}

################################################################################
# Workspace SAML Configuration
################################################################################

output "saml_configuration_status" {
  description = "Status of the SAML configuration"
  value       = try(aws_grafana_workspace_saml_configuration.this[0].status, null)
}

################################################################################
# License Association
################################################################################

output "license_free_trial_expiration" {
  description = "If `license_type` is set to `ENTERPRISE_FREE_TRIAL`, this is the expiration date of the free trial"
  value       = try(aws_grafana_license_association.this[0].free_trial_expiration, null)
}

output "license_expiration" {
  description = "If `license_type` is set to `ENTERPRISE`, this is the expiration date of the enterprise license"
  value       = try(aws_grafana_license_association.this[0].license_expiration, null)
}

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = try(aws_security_group.this[0].arn, null)
}

output "security_group_id" {
  description = "ID of the security group"
  value       = try(aws_security_group.this[0].id, null)
}
