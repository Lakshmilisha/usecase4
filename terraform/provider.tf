provider "google" {
  project                     = var.project_id
  region                      = var.region
  impersonate_service_account = "sa-terraform-deployer@sada-seed-2025-sandbox.iam.gserviceaccount.com"
}

provider "google" {
  alias                       = "tf_sa"
  project                     = var.project_id
  region                      = var.region
  impersonate_service_account = var.tf_service_account_email
}

provider "google" {
  alias                       = "deployer_sa"
  project                     = var.project_id
  region                      = var.region
  impersonate_service_account = "sa-terraform-deployer@sada-seed-2025-sandbox.iam.gserviceaccount.com"
}