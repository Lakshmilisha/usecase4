#  Providers

# Default provider - uses high-privilege deployer SA for IAM operations
provider "google" {
  project                     = var.project_id
  region                      = var.region
  impersonate_service_account = "sa-terraform-deployer@sada-seed-2025-sandbox.iam.gserviceaccount.com"
}

# Alias for TF SA - used for infrastructure provisioning
provider "google" {
  alias                       = "tf_sa"
  project                     = var.project_id
  region                      = var.region
  impersonate_service_account = var.tf_service_account_email
}

# Alias for deployer SA - explicit IAM operations
provider "google" {
  alias                       = "deployer_sa"
  project                     = var.project_id
  region                      = var.region
  impersonate_service_account = "sa-terraform-deployer@sada-seed-2025-sandbox.iam.gserviceaccount.com"
}