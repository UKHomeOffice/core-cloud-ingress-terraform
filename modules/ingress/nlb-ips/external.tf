# Fetch network interfaces for the external NLB
data "aws_network_interfaces" "external_nlb_ips" {
  filter {
    name   = "description"
    values = ["ELB net/${var.ingress_lb_group_name}-external/*"]

  }
}

locals {
  external_nlb_interface_ids = flatten(["${data.aws_network_interfaces.external_nlb_ips.ids}"])
}

data "aws_network_interface" "external_nlb_ips" {
  count = length(local.external_nlb_interface_ids)
  id    = local.external_nlb_interface_ids[count.index]
}

output "aws_external_nlb_network_interface_ips" {
  value = flatten([data.aws_network_interface.external_nlb_ips.*.private_ips])
}
