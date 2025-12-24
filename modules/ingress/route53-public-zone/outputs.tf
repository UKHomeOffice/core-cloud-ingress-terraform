output "acm_records" {
  description = "ACM DNS validation Route53 records created by this module."
  value = [
    for r in values(aws_route53_record.acm_validation) : {
      name    = r.name
      type    = r.type
      value   = one(r.records)
      zone_id = r.zone_id
      ttl     = r.ttl
    }
  ]
}
