terraform {
  backend "gcs" {
    bucket = "neptuno-23-tfstate"
    prefix = "env/dev"
  }
}