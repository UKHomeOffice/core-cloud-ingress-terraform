variable "shared_private_hosted_zones" {
  description = "List of PHZ Zone IDs in other accounts to authorize for this VPC"
  type        = list(string)
}

variable "vpc_id" {
  description = "Current account's VPC ID to authorize/associate"
  type        = string
}

variable "vpc_region" {
  description = "Region of the VPCs"
  type        = string
}
