variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "sada-seed-2025-sandbox"
}

variable "region" {
  description = "Deployment region"
  type        = string
  default     = "us-central1"
}

variable "usecase_name" {
  description = "Unique use case identifier"
  type        = string
  default     = "usecase4"
}

variable "repo_name" {
  description = "Artifact Registry repository name"
  type        = string
  default     = "docker-usecase4-dev"
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "usecase4-webapp-dev"
}

variable "cloudbuild_sa_email" {
  description = "Email of the manually created Cloud Build service account"
  type        = string
}

variable "cloudrun_sa_email" {
  description = "Email of the manually created Cloud Run service account"
  type        = string
}

variable "github_owner" {
  description = "GitHub username or organization"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch_regex" {
  description = "Branch regex for triggering builds"
  type        = string
  default     = "^main$"
}
