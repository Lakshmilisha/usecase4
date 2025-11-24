output "service_url" {
  description = "URL of the Cloud Run service"
  value       = data.google_cloud_run_service.frontend_service.status[0].url
}

output "service_name" {
  description = "Name of the Cloud Run service"
  value       = data.google_cloud_run_service.frontend_service.name
}

output "service_location" {
  description = "Location of the Cloud Run service"
  value       = data.google_cloud_run_service.frontend_service.location
}