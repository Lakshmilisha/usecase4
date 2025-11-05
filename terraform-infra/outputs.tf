output "artifact_registry_repo" {
  description = "Artifact Registry repository name"
  value       = google_artifact_registry_repository.docker_repo.name
}

output "cloud_run_service_name" {
  description = "Deployed Cloud Run service name"
  value       = google_cloud_run_service.frontend_service.name
}
