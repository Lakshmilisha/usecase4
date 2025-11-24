variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "tf_service_account_email" {
  description = "Email of the Terraform service account"
  type        = string
}

variable "cloudbuild_sa_email" {
  description = "Email of the Cloud Build service account"
  type        = string
}

variable "cloudrun_sa_email" {
  description = "Email of the Cloud Run service account"
  type        = string
}