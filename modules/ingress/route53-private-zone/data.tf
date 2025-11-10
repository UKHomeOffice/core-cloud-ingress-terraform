data "aws_route53_zone" "this" {
  for_each = toset(var.private_hosted_zones)

  name         = each.value
  private_zone = true
}
