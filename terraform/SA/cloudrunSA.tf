#cloudrun.tf
# Cloud Run Service Account (pre-created)
data "google_service_account" "cloudrun_sa" {
  provider   = google.deployer_sa
  account_id = "cloudrun-usecase4-dev-sa"
  project    = var.project_id
}



#  IAM Bindings for Cloud Run SA (container)



# Artifact Registry Reader - Pull Docker images (read-only)
resource "google_project_iam_member" "cloudrun_ar_reader" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/artifactregistry.reader"
  member   = "serviceAccount:${data.google_service_account.cloudrun_sa.email}"
}

# Logs Writer - Write application logs
resource "google_project_iam_member" "cloudrun_logs_writer" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/logging.logWriter"
  member   = "serviceAccount:${data.google_service_account.cloudrun_sa.email}"
}
