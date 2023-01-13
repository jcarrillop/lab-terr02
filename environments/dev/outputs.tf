output "network" {
  value = "${module.network.network}"
}

output "subnet" {
  value = "${module.network.subnet}"
}

/* output "firewall_rule" {
  value = "${module.firewall.firewall_rule}"
} */

output "instance_name" {
  value = "${module.instance.instance_name}"
}

output "external_ip" {
  value = "${module.instance.external_ip}"
}