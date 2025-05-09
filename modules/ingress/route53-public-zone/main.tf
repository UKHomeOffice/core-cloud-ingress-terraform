
resource "aws_route53_zone" "aws_r53_zone" {
  count = var.zone_id == "" ? 1 : 0  # Create a new zone only if no zone_id is provided
  name  = var.domain_name
}

# Use the provided zone ID or the one created by Terraform
locals {
  effective_zone_id = var.zone_id != "" ? var.zone_id : aws_route53_zone.aws_r53_zone[0].zone_id
}

# Wait for zone creation (This will be needed for ACM)
resource "time_sleep" "wait_30_seconds" {
  count = var.zone_id == "" ? 1 : 0  # Wait only if a new zone is created
  depends_on = [aws_route53_zone.aws_r53_zone]
  create_duration = "30s"
}


# Create Route53 A Record Alias for External ALB
resource "aws_route53_record" "external_alb" {
  count   = var.alb_dns_ready ? 1 : 0
  zone_id = var.zone_id
  name    = "*.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.external_alb_dns
    zone_id                = var.alb_hosted_zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "acm_validation" {
  for_each = { for record in var.acm_records : record.name => record if length(var.acm_records) > 0 }

  zone_id = local.effective_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}

# Output the hosted zone ID
output "hosted_zone_id" {
  value = local.effective_zone_id
}
