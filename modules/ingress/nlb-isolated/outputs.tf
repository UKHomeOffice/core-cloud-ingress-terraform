output "nlb_dns_name" {
  value = aws_lb.external_nlb.dns_name
  description = "The DNS name of the Network Load Balancer"
}

output "nlb_dns_zone" {
  value = aws_lb.external_nlb.zone_id
  description = "The DNS Zone ID of the Network Load Balancer"
}