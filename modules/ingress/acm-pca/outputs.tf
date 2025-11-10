output "private_zone_cert_arns" {
  description = "ACM cert ARNs per private hosted zone"
  value = {
    for zone, cert in aws_acm_certificate.private_zone_cert :
    zone => cert.arn
  }
}

output "private_zone_cert_domains" {
  description = "Wildcard domain names per private hosted zone"
  value = {
    for zone, cert in aws_acm_certificate.private_zone_cert :
    zone => cert.domain_name
  }
}

output "private_zone_cert_ids" {
  description = "ACM certificate IDs per private hosted zone"
  value = {
    for zone, cert in aws_acm_certificate.private_zone_cert :
    zone => cert.id
  }
}
