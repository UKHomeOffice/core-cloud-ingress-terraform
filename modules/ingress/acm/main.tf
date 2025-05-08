resource "aws_acm_certificate" "cert" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  # Optional: Add SANs (Subject Alternative Names) if required
  # subject_alternative_names = ["www.${var.domain_name}"]


  lifecycle {
    create_before_destroy = true
  }

  # Apply tags if required
  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Tenant      = var.tenant
    }
  )


}


output "acm_validation_records" {
  description = "ACM Certificate DNS Validation Records"
  value = [
    for dvo in aws_acm_certificate.cert.domain_validation_options : {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  ]
}



# CREATED ONLY FOR WORKLOAD ACCOUNTS
# Create DNS records for certificate validation in Route 53
resource "aws_route53_record" "cert_validation_records" {
  for_each = var.workload ? {
    for dvo in aws_acm_certificate.cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  } : {}

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 60

  lifecycle {
    create_before_destroy = true  # Create new record before destroying the old one
  }
}


# After the DNS records are created, validate the certificate
resource "aws_acm_certificate_validation" "cert_validation" {
  count   = var.workload && var.acm_validation_enabled ? 1 : 0  # Only create validation if both conditions are true
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation_records : r.fqdn]

  depends_on = [aws_route53_record.cert_validation_records]

  timeouts {
    create = "5m"  # Adjust timeout based on your needs
  }
}
