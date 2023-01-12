
locals {
  env = "dev"
}

provider "google" {
  project = "${var.project}"
}

module "network" {
  source  = "../../modules/network"
  project = "${var.project}"
  env     = "${local.env}"
}

module "instance" {
  source  = "../../modules/instance"
  project = "${var.project}"
  subnet  = "${module.network.subnet}"
}

module "firewall" {
  source  = "../../modules/firewall"
  project = "${var.project}"
  subnet  = "${module.network.subnet}"
}