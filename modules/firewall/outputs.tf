output "firewall_rule" {
  value = "${google_compute_firewall.fr_allow_internal.name}"
}