locals {
  env = "dev"
}

provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
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

module "appengine" {
  source  = "../../modules/appengine"
  project = "${var.project}"
  subnet  = "${module.network.subnet}"
}

module "redis" {
  source  = "../../modules/redis"
  project = "${var.project}"
  subnet  = "${module.network.subnet}"
}

module "storage" {
  source  = "../../modules/storage"
  project = "${var.project}"
}