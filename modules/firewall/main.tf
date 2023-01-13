locals {
  network = "${element(split("-", var.subnet), 0)}"
}

resource "google_compute_firewall" "fr_allow-internal" {
  
  direction   = "INGRESS"
  name        = "fr-${local.network}-allow-internal"
  network     = "${local.network}"
  project     = "${var.project}"
  priority    = 1000
  

  allow {
    protocol = "tcp"
  }

    allow {
    protocol = "udp"
  }

  source_ranges = ["10.10.10.0/24", "10.110.0.0/24"]
}

resource "google_compute_firewall" "fr_allow_ssh" {
  name        = "${local.network}-allow-ssh"
  network     = "${local.network}"
  project     = "${var.project}"
  priority    = 65534

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["ssh-connect"]
  #source_ranges = ["0.0.0.0/0"]
  
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
  #source_ranges = ["0.0.0.0/0"]
  target_tags   = ["icmp"]
}

