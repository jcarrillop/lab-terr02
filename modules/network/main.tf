module "network_vpc" {
  source  = "terraform-google-modules/network/google"
  version = "3.3.0"

  project_id   = "${var.project}"
  network_name = "${var.env}"


  subnets = [
    {
      subnet_name   = "${var.env}-subnet-01"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.10.0/24"
      subnet_region = "us-west1"
    },
        {
      subnet_name   = "${var.env}-subnet-02"
      subnet_ip     = "10.${var.env == "prod" ? 110 : 210}.0.0/24"
      subnet_region = "us-west1"
    }
  ]

  secondary_ranges = {
    "${var.env}-subnet-01" = []
    "${var.env}-subnet-02" = []
  }
}

resource "google_compute_network" "network" {
  name                    = "${var.app_name}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "data" {
  name                     = "${var.app_name}-data-subnet"
  ip_cidr_range            = var.app_ip_range
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}