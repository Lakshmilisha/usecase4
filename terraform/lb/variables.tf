variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "sada-seed-2025-sandbox"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "Base name for resources"
  type        = string
  default     = "usecase4-webapp"
}

variable "cloud_run_service_name" {
  description = "Existing Cloud Run service name"
  type        = string
  default     = "usecase4-webapp-dev"
}

variable "domain_name" {
  description = "Custom domain name"
  type        = string
  default     = "usecase4.xyz"
}

# IAP OAuth credentials (you need to create these)
variable "iap_client_id" {
  description = "OAuth 2.0 Client ID for IAP"
  type        = string
  sensitive   = true
}

variable "iap_client_secret" {
  description = "OAuth 2.0 Client Secret for IAP"
  type        = string
  sensitive   = true
}