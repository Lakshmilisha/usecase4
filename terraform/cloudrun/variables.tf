variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Deployment region"
  type        = string
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
}

variable "cloudbuild_sa_email" {
  description = "Email of the Cloud Build service account"
  type        = string
}