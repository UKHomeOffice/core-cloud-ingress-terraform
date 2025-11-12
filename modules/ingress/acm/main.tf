
# ACM certificate (only when enabled)
resource "aws_acm_certificate" "cert" {
  count             = var.external_ingress ? 1 : 0
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Tenant      = var.tenant
    }
  )
}

# Output safe when disabled
output "acm_validation_records" {
  description = "ACM Certificate DNS Validation Records"
  value = var.external_ingress
    ? [
        for dvo in aws_acm_certificate.cert[0].domain_validation_options : {
          name  = dvo.resource_record_name
          type  = dvo.resource_record_type
          value = dvo.resource_record_value
        }
      ]
    : []
}

# DNS records for validation — only for workload accounts AND when enabled
resource "aws_route53_record" "cert_validation_records" {
  for_each = (var.external_ingress && var.workload && length(try(aws_acm_certificate.cert[0].domain_validation_options, [])) > 0) ? {
        for dvo in aws_acm_certificate.cert[0].domain_validation_options :
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
    create_before_destroy = true
  }
}

# Certificate validation — only when enabled AND workload flow
resource "aws_acm_certificate_validation" "cert_validation" {
  count = (var.external_ingress && var.workload && var.acm_validation_enabled) ? 1 : 0

  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation_records : r.value.name] # or r.fqdn if preferred

  depends_on = [aws_route53_record.cert_validation_records]

  timeouts {
    create = "5m"
  }
}
