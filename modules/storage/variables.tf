variable "project" {}
variable "subnet" {}


variable "app_name" {
  default = "app-3t-gce"
}

variable "location_id" {
  default = "us-west"
}

variable "region" {
  default = "us-west1"
}

variable "app_ip_range" {
  default = "10.1.0.0/28"
}

variable "redis_memory_size_gb" {
  default = 1
}

variable "min_instances" {
  default = 2
}

variable "max_instances" {
  default = 5
}