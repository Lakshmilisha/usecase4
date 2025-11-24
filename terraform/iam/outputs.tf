
output "tf_sa_roles" {
  description = "Roles assigned to Terraform Service Account"
  value = [
    google_project_iam_member.tf_sa_artifact_admin.role,
    google_project_iam_member.tf_sa_run_admin.role,
    google_project_iam_member.tf_sa_run_viewer.role,
    google_project_iam_member.tf_sa_sa_user.role,
    google_project_iam_member.tf_sa_service_usage.role,
  ]
}

output "cloudbuild_sa_roles" {
  description = "Roles assigned to Cloud Build Service Account"
  value = [
    google_project_iam_member.cloudbuild_run_developer.role,
    google_project_iam_member.cloudbuild_sa_user.role,
    google_project_iam_member.cloudbuild_ar_writer.role,
    google_project_iam_member.cloudbuild_logs_writer.role,
    google_project_iam_member.cloudbuild_approver.role,
  ]
}

output "cloudrun_sa_roles" {
  description = "Roles assigned to Cloud Run Service Account"
  value = [
    google_project_iam_member.cloudrun_ar_reader.role,
    google_project_iam_member.cloudrun_logs_writer.role,
  ]
}

output "cloudbuild_sa_email" {
  description = "Email of the Cloud Build service account"
  value       = data.google_service_account.cloudbuild_sa.email
}

output "cloudrun_sa_email" {
  description = "Email of the Cloud Run service account"
  value       = data.google_service_account.cloudrun_sa.email
}