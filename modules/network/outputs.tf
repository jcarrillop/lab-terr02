output "network" {
  value = "${module.network.network_name}"
}

output "subnet" {
  value = "${element(module.network.subnets_names, 0)}"
}