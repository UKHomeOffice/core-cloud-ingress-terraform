resource "aws_route53_vpc_association_authorization" "phz_association_authorization" {
  for_each = toset(var.shared_private_hosted_zones)  # Zone IDs of PHZs in other accounts

  zone_id    = each.value  # Use `each.value` because it's a set of strings
  vpc_id     = var.vpc_id
  vpc_region = var.vpc_region
}
