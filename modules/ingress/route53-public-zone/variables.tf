variable "tags" {
  type        = map(string)
  description = "Tags to apply to AWS resources"
}

variable "environment" {
  description = "The environment (prod/non-prod)"
  type        = string
}

variable "tenant" {
  description = "The tenant name"
  type        = string
}

variable "acm_records" {
  type    = list(object({ name = string, type = string, value = string }))
  default = []
}



variable "external_alb_dns" {
  description = "The DNS name of the external ALB"
  type        = string
  default     = ""
}

variable "alb_hosted_zone_id" {
  description = "The DNS ZONE name of the external ALB"
  type        = string
  default     = ""
}



variable "alb_dns_ready" {
  description = "Flag to determine if the ALB Route 53 record should be created"
  type        = bool
  default     = false
}

variable "domain_name" {
  description = "The domain name for the Route 53 record"
  type        = string
}

variable "zone_id" {
  description = "The hosted zone ID for Route 53"
  type        = string
}