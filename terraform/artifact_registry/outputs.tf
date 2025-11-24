output "repository_name" {
  description = "Name of the Artifact Registry repository"
  value       = google_artifact_registry_repository.docker_repo.name
}

output "repository_id" {
  description = "Full ID of the Artifact Registry repository"
  value       = google_artifact_registry_repository.docker_repo.id
}