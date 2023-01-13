output "network" {
  value = "${module.network_vpc.network_name}"
}

output "subnet" {
  value = "${element(module.network_vpc.subnets_names, 0)}"
}