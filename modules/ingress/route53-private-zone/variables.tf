variable "private_hosted_zones" {
  description = "List of private hosted zone names to create wildcard records in"
  type        = list(string)
}

variable "internal_nlb_dns_name" {
  description = "DNS name of the internal NLB to target"
  type        = string
}

variable "internal_nlb_zone_id" {
  description = "Hosted zone ID of the internal NLB"
  type        = string
}
