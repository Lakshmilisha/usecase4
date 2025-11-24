output "artifact_registry_repo" {
  description = "Name of the created Artifact Registry repository"
  value       = module.artifact_registry.repository_name
}

output "artifact_registry_repo_id" {
  description = "Full ID of the Artifact Registry repository"
  value       = module.artifact_registry.repository_id
}

output "cloud_run_service_url" {
  description = "URL of the Cloud Run service"
  value       = module.cloud_run.service_url
}

output "cloud_run_service_name" {
  description = "Name of the Cloud Run service"
  value       = module.cloud_run.service_name
}

output "tf_service_account_roles" {
  description = "Roles assigned to the Terraform Service Account"
  value       = module.iam.tf_sa_roles
}

output "cloudbuild_sa_roles" {
  description = "Roles assigned to the Cloud Build Service Account"
  value       = module.iam.cloudbuild_sa_roles
}

output "cloudrun_sa_roles" {
  description = "Roles assigned to the Cloud Run Service Account"
  value       = module.iam.cloudrun_sa_roles
}
