#cloudbuild.tf
# Cloud Build Service Account (pre-created)
data "google_service_account" "cloudbuild_sa" {
  provider   = google.deployer_sa
  account_id = "cloudbuild-usecase4-dev-sa"
  project    = var.project_id
}

#  IAM Bindings for Cloud Build SA (Least Privilege)



# run.developer can deploy but not delete services
resource "google_project_iam_member" "cloudbuild_run_developer" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/run.developer"
  member   = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}"
}

# Service Account User - Deploy as Cloud Run SA
resource "google_project_iam_member" "cloudbuild_sa_user" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/iam.serviceAccountUser"
  member   = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}"
}

# Artifact Registry Writer - Push built Docker images
resource "google_project_iam_member" "cloudbuild_ar_writer" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/artifactregistry.writer"
  member   = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}"
}



# Logs Writer - Write Cloud Build logs
resource "google_project_iam_member" "cloudbuild_logs_writer" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/logging.logWriter"
  member   = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}"
}

# Cloud Build SA permissions for builds & logs 
resource "google_project_iam_member" "cloudbuild_approver" { 
  provider = google.deployer_sa 
  project = var.project_id 
  role = "roles/cloudbuild.builds.approver" 
  member = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}" 
}