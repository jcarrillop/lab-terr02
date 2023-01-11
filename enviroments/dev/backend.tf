terraform {
  backend "gcs" {
    bucket = "${var.project}-tfstate"
    prefix = "env/dev"
  }
}