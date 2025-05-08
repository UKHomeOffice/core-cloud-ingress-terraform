variable "tags" {
  type        = map(string)
  description = "Tags to apply to AWS resources"
}

variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "environment" {
  description = "The environment (prod/non-prod)"
  type        = string
}

variable "tenant" {
  description = "The tenant name"
  type        = string
}

variable "workload" {
  type    = bool
  default = false
}


variable "hosted_zone_id" {
  description = "The zone id"
  type        = string
  default = ""
}

variable "acm_validation_enabled" {
  type    = bool
  default = false  # Set to false for skipping validation during plan
}
