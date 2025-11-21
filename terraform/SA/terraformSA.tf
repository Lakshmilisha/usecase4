#  Bootstrap Section - Assign Least Privilege Roles to TF SA
#  (sa-tf-usecase4)

#terraformSA.tf

# 1. Artifact Registry Admin - Create and manage repositories
resource "google_project_iam_member" "tf_sa_artifact_admin" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/artifactregistry.admin"
  member   = "serviceAccount:${var.tf_service_account_email}"
}

# 2. Cloud Run Admin - Create and manage Cloud Run services
resource "google_project_iam_member" "tf_sa_run_admin" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/run.admin"
  member   = "serviceAccount:${var.tf_service_account_email}"

}

# 4. Cloud Run Viewer - Allows reading service metadata
resource "google_project_iam_member" "tf_sa_run_viewer" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/run.viewer"
  member   = "serviceAccount:${var.tf_service_account_email}"
}

# 3. Service Account User - Assign SAs to Cloud Run services
resource "google_project_iam_member" "tf_sa_sa_user" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/iam.serviceAccountUser"
  member   = "serviceAccount:${var.tf_service_account_email}"
}



# 5. Service Usage Consumer - View/consume enabled APIs
resource "google_project_iam_member" "tf_sa_service_usage" {
  provider = google.deployer_sa
  project  = var.project_id
  role     = "roles/serviceusage.serviceUsageConsumer"
  member   = "serviceAccount:${var.tf_service_account_email}"
}
