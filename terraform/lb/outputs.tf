output "load_balancer_ip" {
  value = google_compute_global_address.lb_ip.address
  description = "Static IP of the Load Balancer"
}


output "https_forwarding_rule_id" {
  value = google_compute_global_forwarding_rule.https_forwarding_rule.id
  description = "ID of the HTTPS forwarding rule"
}


output "domain_name" {
  description = "Your domain name"
  value       = var.domain_name
}

output "dns_instructions" {
  description = "DNS configuration instructions"
  value       = "Add A record: ${var.domain_name} -> ${google_compute_global_address.lb_ip.address}"
}
