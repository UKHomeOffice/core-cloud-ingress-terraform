variable "tags" {
  type        = map(string)
  description = "Tags to apply to AWS resources"
}

variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "workload" {
  type    = bool
  default = false
}

variable "acm_validation_enabled" {
  type    = bool
  default = false # Set to false for skipping validation during plan
}
