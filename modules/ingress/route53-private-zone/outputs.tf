output "wildcard_record_fqdns" {
  description = "Map of zone name to wildcard record FQDN"
  value = {
    for name, rec in aws_route53_record.wildcard_nlb :
    name => rec.fqdn
  }
}
