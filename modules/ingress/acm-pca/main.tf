locals {
  # Map each zone name to its wildcard domain: "zone1" -> "*.zone1"
  wildcard_domains = {
    for z in var.private_hosted_zones :
    z => "*.${z}"
  }
}

resource "aws_acm_certificate" "private_zone_cert" {
  for_each = local.wildcard_domains

  domain_name               = each.value
  certificate_authority_arn = var.subordinate_ca_arn

  options {
    certificate_transparency_logging_preference = "DISABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
}
