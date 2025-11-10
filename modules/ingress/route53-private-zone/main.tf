resource "aws_route53_record" "wildcard_nlb" {
  for_each = data.aws_route53_zone.this

  zone_id = each.value.zone_id
  name    = "*.${chomp(each.value.name)}"
  type    = "A"

  alias {
    name                   = var.internal_nlb_dns_name
    zone_id                = var.internal_nlb_zone_id
    evaluate_target_health = false
  }
}
