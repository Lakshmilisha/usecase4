#main.tf
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.6.0"
}




#  Cloud Run Service

data "google_cloud_run_service" "frontend_service" {
  provider = google.tf_sa
  name     = var.service_name
  location = var.region

}   

# Allow Cloud Build service account to invoke the Cloud Run service
resource "google_cloud_run_service_iam_member" "invoker_cloudbuild" {
  service  = data.google_cloud_run_service.frontend_service.name
  location = data.google_cloud_run_service.frontend_service.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.cloudbuild_sa_email}"
}




