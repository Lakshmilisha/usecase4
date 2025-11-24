data "google_service_account" "cloudbuild_sa" {
  account_id = split("@", var.cloudbuild_sa_email)[0]
  project    = var.project_id
}

data "google_service_account" "cloudrun_sa" {
  account_id = split("@", var.cloudrun_sa_email)[0]
  project    = var.project_id
}

# Terraform SA IAM Bindings
resource "google_project_iam_member" "tf_sa_artifact_admin" {
  project = var.project_id
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${var.tf_service_account_email}"
}

resource "google_project_iam_member" "tf_sa_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${var.tf_service_account_email}"
}

resource "google_project_iam_member" "tf_sa_run_viewer" {
  project = var.project_id
  role    = "roles/run.viewer"
  member  = "serviceAccount:${var.tf_service_account_email}"
}

resource "google_project_iam_member" "tf_sa_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${var.tf_service_account_email}"
}

resource "google_project_iam_member" "tf_sa_service_usage" {
  project = var.project_id
  role    = "roles/serviceusage.serviceUsageConsumer"
  member  = "serviceAccount:${var.tf_service_account_email}"
}

# Cloud Build SA IAM Bindings
resource "google_project_iam_member" "cloudbuild_run_developer" {
  project = var.project_id
  role    = "roles/run.developer"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}"
}

resource "google_project_iam_member" "cloudbuild_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}"
}

resource "google_project_iam_member" "cloudbuild_ar_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}"
}

resource "google_project_iam_member" "cloudbuild_logs_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}"
}

resource "google_project_iam_member" "cloudbuild_approver" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.approver"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_sa.email}"
}

# Cloud Run SA IAM Bindings
resource "google_project_iam_member" "cloudrun_ar_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${data.google_service_account.cloudrun_sa.email}"
}

resource "google_project_iam_member" "cloudrun_logs_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${data.google_service_account.cloudrun_sa.email}"
}