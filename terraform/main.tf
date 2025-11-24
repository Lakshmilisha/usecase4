terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.6.0"
}

# Artifact Registry Module
module "artifact_registry" {
  source = "./modules/artifact-registry"

  project_id   = var.project_id
  region       = var.region
  repo_name    = var.repo_name
  usecase_name = var.usecase_name

  providers = {
    google = google.tf_sa
  }
}

# Cloud Run Module
module "cloud_run" {
  source = "./modules/cloud-run"

  project_id          = var.project_id
  region              = var.region
  service_name        = var.service_name
  cloudbuild_sa_email = var.cloudbuild_sa_email

  providers = {
    google = google.tf_sa
  }
}

# IAM Module
module "iam" {
  source = "./modules/iam"

  project_id               = var.project_id
  tf_service_account_email = var.tf_service_account_email
  cloudbuild_sa_email      = var.cloudbuild_sa_email
  cloudrun_sa_email        = var.cloudrun_sa_email

  providers = {
    google = google.deployer_sa
  }
}