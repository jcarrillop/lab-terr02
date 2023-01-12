
locals {
  env = "dev"
}

provider "google" {
  project = "${var.project}"
}

module "network" {
  source  = "../../modules/Network"
  project = "${var.project}"
  env     = "${local.env}"
}

module "instance" {
  source  = "../../modules/instance"
  project = "${var.project}"
  subnet  = "${module.network.subnets}"
}

module "firewall" {
  source  = "../../modules/firewall"
  project = "${var.project}"
  subnet  = "${module.network.subnets}"
}