terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.6.0"
}

provider "google" {
  project                    = var.project_id
  region                     = var.region
  impersonate_service_account = "sa-terraform-deployer@sada-seed-2025-sandbox.iam.gserviceaccount.com"
}


# Assign Roles to the Pre-created TF Service Account


# Give project-level permissions for provisioning infrastructure
resource "google_project_iam_member" "tf_sa_editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${var.tf_service_account_email}"
}

# Allow impersonation of other service accounts (needed to create CB/CR SAs)
resource "google_project_iam_member" "tf_sa_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${var.tf_service_account_email}"
}

# Allow management of service accounts
resource "google_project_iam_member" "tf_sa_sa_admin" {
  project = var.project_id
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:${var.tf_service_account_email}"
}

# Allow deployment management (optional, for Cloud Run)
resource "google_project_iam_member" "tf_sa_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${var.tf_service_account_email}"
}

# Allow Artifact Registry access
resource "google_project_iam_member" "tf_sa_artifact_admin" {
  project = var.project_id
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${var.tf_service_account_email}"
}
