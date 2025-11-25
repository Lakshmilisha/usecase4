

resource "google_artifact_registry_repository" "docker_repo" {
  provider      = google.tf_sa
  location      = var.region
  repository_id = var.repo_name
  description   = "Docker repository for ${var.usecase_name}"
  format        = "DOCKER"
  
}
