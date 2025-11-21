#outputs.tf
output "artifact_registry_repo" {
  description = "Name of the created Artifact Registry repository"
  value       = google_artifact_registry_repository.docker_repo.name
}

output "cloud_run_service_url" {
  value = data.google_cloud_run_service.frontend_service.status[0].url
}


output "tf_service_account_roles" {
  description = "Roles assigned to the Terraform Service Account"
  value = [
    google_project_iam_member.tf_sa_run_admin.role,
    google_project_iam_member.tf_sa_artifact_admin.role,
    google_project_iam_member.tf_sa_sa_user.role
  ]
}
