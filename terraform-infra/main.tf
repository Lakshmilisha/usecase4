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
  impersonate_service_account = "sa-tf-usecase4@sada-seed-2025-sandbox.iam.gserviceaccount.com"
}


# Service Accounts


# Cloud Build Service Account
resource "google_service_account" "cloudbuild_sa" {
  account_id   = "cloudbuild-${var.usecase_name}-dev-sa"
  display_name = "Cloud Build Service Account for ${var.usecase_name}"
}

# Cloud Run Service Account
resource "google_service_account" "cloudrun_sa" {
  account_id   = "cloudrun-${var.usecase_name}-dev-sa"
  display_name = "Cloud Run Service Account for ${var.usecase_name}"
}


# Artifact Registry

resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.repo_name
  description   = "Docker repo for ${var.usecase_name}"
  format        = "DOCKER"
}

# --------------------------------------------------------------------
# Cloud Run Service (placeholder image)
# --------------------------------------------------------------------
resource "google_cloud_run_service" "frontend_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.cloudrun_sa.email
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello" # placeholder
      }
    }
  }

  autogenerate_revision_name = true
}


# IAM Role Bindings


# Cloud Build SA → Deploy to Cloud Run
resource "google_project_iam_member" "cb_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}

# Cloud Build SA → Push to Artifact Registry
resource "google_project_iam_member" "cb_artifact_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}

# Cloud Build SA → Act as Cloud Run SA
resource "google_project_iam_member" "cb_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}

# Cloud Run SA → Logging
resource "google_project_iam_member" "cr_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}

# Cloud Run SA → Monitoring (optional)
resource "google_project_iam_member" "cr_monitor_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}

# --------------------------------------------------------------------
# Cloud Build Trigger (connects to GitHub)
# --------------------------------------------------------------------

resource "google_cloudbuild_trigger" "usecase4_trigger" {
  name = "${var.usecase_name}-webapp-trigger"

  github {
    owner = var.github_owner
    name  = var.github_repo

    push {
      branch = var.github_branch_regex
    }
  }

  filename = "app/cloudbuild.yaml"

  substitutions = {
    _REGION       = var.region
    _REPO_NAME    = var.repo_name
    _SERVICE_NAME = var.service_name
  }

  service_account = google_service_account.cloudbuild_sa.email
}
