locals {
  network = "${element(split("-", var.subnet), 0)}"
}

resource "google_compute_firewall" "fr_allow_internal" {
  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  direction     = "INGRESS"
  name          = "fr-${local.network}-allow-internal"
  network       = "${local.network}"
  priority      = 1000
  project       = "${var.project}"
  source_ranges = ["10.10.10.0/24", "10.110.0.0/24"]
}

resource "google_compute_firewall" "fr_allow_ssh" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  description   = "Allows TCP connections from any source to any instance on the network using port 22."
  direction     = "INGRESS"
  name          = "fr-${local.network}-allow-ssh"
  network       = "${local.network}"
  priority      = 65534
  project       = "${var.project}"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-connect"]
}

resource "google_compute_firewall" "fr_allow_icmp" {
  allow {
    protocol = "icmp"
  }

  description   = "Allows ICMP connections from any source to any instance on the network."
  direction     = "INGRESS"
  name          = "fr-${local.network}-allow-icmp"
  network       = "${local.network}"
  priority      = 65534
  project       = "${var.project}"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["icmp"]
}

