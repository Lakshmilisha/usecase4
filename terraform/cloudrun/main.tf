data "google_cloud_run_service" "frontend_service" {
  name     = var.service_name
  location = var.region
}

resource "google_cloud_run_service_iam_member" "invoker_cloudbuild" {
  service  = data.google_cloud_run_service.frontend_service.name
  location = data.google_cloud_run_service.frontend_service.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.cloudbuild_sa_email}"
}
