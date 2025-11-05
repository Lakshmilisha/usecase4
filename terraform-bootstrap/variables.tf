variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "sada-seed-2025-sandbox"
}

variable "region" {
  description = "Deployment region"
  type        = string
  default     = "us-central1"
}

variable "tf_service_account_email" {
  description = "Email of the manually created Terraform service account"
  type        = string
}
