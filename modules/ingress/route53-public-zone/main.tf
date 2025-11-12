variable "external_ingress" {
  description = "If false, skip creating any external DNS resources"
  type        = bool
  default     = true
}

# Create a zone only if external_ingress is true AND no zone_id provided
resource "aws_route53_zone" "aws_r53_zone" {
  count = (var.external_ingress && var.zone_id == "") ? 1 : 0
  name  = var.domain_name
}

# Use provided zone_id, otherwise created one (or null if not created)
locals {
  effective_zone_id = var.zone_id != "" ? var.zone_id : try(aws_route53_zone.aws_r53_zone[0].zone_id, null)
}

# Wait only if we created the zone (and external_ingress is true)
resource "time_sleep" "wait_30_seconds" {
  count           = (var.external_ingress && var.zone_id == "") ? 1 : 0
  depends_on      = [aws_route53_zone.aws_r53_zone]
  create_duration = "30s"
}

# A-record alias only when external_ingress is true and ALB DNS is ready
resource "aws_route53_record" "external_alb" {
  count   = (var.external_ingress && var.alb_dns_ready) ? 1 : 0
  zone_id = local.effective_zone_id
  name    = "*.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.external_alb_dns
    zone_id                = var.alb_hosted_zone_id
    evaluate_target_health = true
  }
}

# ACM validation records only when external_ingress is true
resource "aws_route53_record" "acm_validation" {
  for_each = (var.external_ingress && length(var.acm_records) > 0) ? { for record in var.acm_records : record.name => record } : {}

  zone_id = local.effective_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}

# Output is null when external_ingress is false
output "hosted_zone_id" {
  description = "Hosted zone ID used for external ingress (null if disabled)"
  value       = var.external_ingress ? local.effective_zone_id : null
}
