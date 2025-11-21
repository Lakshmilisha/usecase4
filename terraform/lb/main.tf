terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.0"
    }
  }
  backend "gcs" {
    bucket = "usecase4-dev-tfstate"
    prefix = "terraform/lb"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Get project number for IAP service account
data "google_project" "project" {
  project_id = var.project_id
}

# Global static IP
resource "google_compute_global_address" "lb_ip" {
  name = "${var.service_name}-lb-ip"
}

# Managed SSL certificate
resource "google_compute_managed_ssl_certificate" "ssl_certificate" {
  name = "${var.service_name}-certificate"
  
  managed {
    domains = [var.domain_name]
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

# Serverless NEG for existing Cloud Run
resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "${var.service_name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region

  cloud_run {
    service = var.cloud_run_service_name
  }
}

# Backend service with HTTPS (FIXED!)
resource "google_compute_backend_service" "backend" {
  name                  = "${var.service_name}-backend"
  protocol              = "HTTPS"  # ✅ Changed from HTTP to HTTPS
  port_name             = "http"
  timeout_sec           = 30
  enable_cdn            = false
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group = google_compute_region_network_endpoint_group.cloudrun_neg.id
  }

  iap {
  oauth2_client_id     = var.iap_client_id
  oauth2_client_secret = var.iap_client_secret
  enabled              = true   # Note: It's "enabled", not "enable"
}


  log_config {
    enable      = true
    sample_rate = 1.0
  }
}

# URL Map for HTTPS
resource "google_compute_url_map" "urlmap" {
  name            = "${var.service_name}-urlmap"
  default_service = google_compute_backend_service.backend.id
}

# HTTPS Proxy
resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "${var.service_name}-https-proxy"
  url_map          = google_compute_url_map.urlmap.id
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_certificate.id]
}

# HTTPS Forwarding Rule
resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  name                  = "${var.service_name}-https-rule"
  target                = google_compute_target_https_proxy.https_proxy.id
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  ip_address            = google_compute_global_address.lb_ip.address
}

# HTTP -> HTTPS redirect
resource "google_compute_url_map" "http_redirect" {
  name = "${var.service_name}-http-redirect"

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.service_name}-http-proxy"
  url_map = google_compute_url_map.http_redirect.id
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name                  = "${var.service_name}-http-rule"
  target                = google_compute_target_http_proxy.http_proxy.id
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  ip_address            = google_compute_global_address.lb_ip.address
}





