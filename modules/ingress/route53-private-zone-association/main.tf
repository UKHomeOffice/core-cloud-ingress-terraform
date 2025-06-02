
resource "aws_route53_zone_association" "phz_association" {
  for_each = toset(var.phz_vpcs_to_associate)  # List of VPC IDs

  zone_id = var.private_zone_id                # Single PHZ Zone ID in this account
  vpc_id  = each.value
}
