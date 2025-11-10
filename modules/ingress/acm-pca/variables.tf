variable "private_hosted_zones" {
  description = "List of private hosted zone names (e.g. example.internal, corp.local)"
  type        = list(string)
}

variable "subordinate_ca_arn" {
  description = "ARN of the ACM Private CA (subordinate)"
  type        = string
}