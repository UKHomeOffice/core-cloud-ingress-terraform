resource "aws_acm_certificate" "internal_cert" {
  count             = var.workload ? 1 : 0
  domain_name       = "*.internal.${var.domain_name}"
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

resource "aws_route53_record" "internal_cert_validation_records" {
  for_each = var.workload && length(aws_acm_certificate.internal_cert) > 0 ? {
    for dvo in aws_acm_certificate.internal_cert[0].domain_validation_options :
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

resource "aws_acm_certificate_validation" "internal_cert_validation" {
  count = var.workload && var.acm_validation_enabled ? 1 : 0

  certificate_arn         = aws_acm_certificate.internal_cert[0].arn
  validation_record_fqdns = [for r in aws_route53_record.internal_cert_validation_records : r.fqdn]

  depends_on = [aws_route53_record.internal_cert_validation_records]

  timeouts {
    create = "5m"
  }
}
