

# Fetch network interfaces for the external NLB
data "aws_network_interfaces" "external_nlb_ifs" {
  filter {
    name   = "description"
    values = ["ELB net/${var.ingress_lb_group_name}-external/*"]

  }
}

locals {
  external_nlb_interface_ids = "${flatten(["${data.aws_network_interfaces.external_nlb_ifs.ids}"])}"
}

data "aws_network_interface" "external_nlb_ips" {
  count = var.apply_only ? length(local.external_nlb_interface_ids) : 0
  id = "${local.external_nlb_interface_ids[count.index]}"
  
}

output "aws_external_nlb_network_interface_ips" {
  value = "${flatten([data.aws_network_interface.external_nlb_ips.*.private_ips])}"
}