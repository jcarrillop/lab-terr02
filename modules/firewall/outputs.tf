output "firewall_rule" {
  value = "${google_compute_firewall.fr_allow_internal.name}"
}

output "firewall_rule" {
  value = "${google_compute_firewall.fr_allow_ssh.name}"
}

output "firewall_rule" {
  value = "${google_compute_firewall.fr_allow_icmp.name}"
}


