################################################################################
# Workspace
################################################################################

output "workspace_arn" {
  description = "The Amazon Resource Name (ARN) of the Grafana workspace"
  value       = module.managed_grafana.workspace_arn
}

output "workspace_id" {
  description = "The ID of the Grafana workspace"
  value       = module.managed_grafana.workspace_id
}

output "workspace_endpoint" {
  description = "The endpoint of the Grafana workspace"
  value       = module.managed_grafana.workspace_endpoint
}

output "workspace_grafana_version" {
  description = "The version of Grafana running on the workspace"
  value       = module.managed_grafana.workspace_grafana_version
}

################################################################################
# Workspace API Key
################################################################################

output "workspace_api_keys" {
  description = "The workspace API keys created including their attributes"
  value       = module.managed_grafana.workspace_api_keys
  sensitive   = true
}

################################################################################
# Serivce accounts token
################################################################################

output "workspace_sa_tokens" {
  description = "The workspace API keys created including their attributes"
  value       = module.managed_grafana.workspace_sa_tokens
  sensitive   = true
}

################################################################################
# Workspace IAM Role
################################################################################

output "workspace_iam_role_name" {
  description = "IAM role name of the Grafana workspace"
  value       = module.managed_grafana.workspace_iam_role_name
}

output "workspace_iam_role_arn" {
  description = "IAM role ARN of the Grafana workspace"
  value       = module.managed_grafana.workspace_iam_role_arn
}

output "workspace_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.managed_grafana.workspace_iam_role_unique_id
}

################################################################################
# Workspace IAM Policy
################################################################################

output "workspace_iam_role_policy_arn" {
  description = "IAM Policy ARN of the Grafana workspace IAM role"
  value       = module.managed_grafana.workspace_iam_role_policy_arn
}

output "workspace_iam_role_policy_name" {
  description = "IAM Policy name of the Grafana workspace IAM role"
  value       = module.managed_grafana.workspace_iam_role_policy_name
}

output "workspace_iam_role_policy_id" {
  description = "Stable and unique string identifying the IAM Policy"
  value       = module.managed_grafana.workspace_iam_role_policy_id
}

################################################################################
# Workspace SAML Configuration
################################################################################

output "saml_configuration_status" {
  description = "Status of the SAML configuration"
  value       = module.managed_grafana.saml_configuration_status
}

################################################################################
# License Association
################################################################################

output "license_free_trial_expiration" {
  description = "If `license_type` is set to `ENTERPRISE_FREE_TRIAL`, this is the expiration date of the free trial"
  value       = module.managed_grafana.license_free_trial_expiration
}

output "license_expiration" {
  description = "If `license_type` is set to `ENTERPRISE`, this is the expiration date of the enterprise license"
  value       = module.managed_grafana.license_expiration
}
