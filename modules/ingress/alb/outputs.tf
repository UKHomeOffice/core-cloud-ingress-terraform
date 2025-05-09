# Outputs
output "alb_dns_name" {
  value = aws_lb.tenant_alb.dns_name
}

output "alb_hosted_zone_id" {
  value = data.aws_lb_hosted_zone_id.main.id
}

output "vpc_id" {
  value = data.aws_vpcs.filtered_vpcs.ids[0]
}

output "public_subnets" {
  value = data.aws_subnets.filtered_subnets.ids
}
