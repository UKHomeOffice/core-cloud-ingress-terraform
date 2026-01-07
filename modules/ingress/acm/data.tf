data "aws_route53_zone" "selected" {
  count = var.workload ? 1 : 0
  name = var.domain_name
}
