##################################
# outputs.tf
##################################

output "internal_nlb_dns_name" {
  description = "DNS name of the internal NLB"
  value       = aws_lb.internal_nlb.dns_name
}

output "internal_nlb_zone_id" {
  description = "Hosted zone ID of the internal NLB"
  value       = aws_lb.internal_nlb.zone_id
}
