
variable "phz_vpcs_to_associate" {
  description = "List of VPC IDs to associate with the PHZ"
  type        = list(string)
}

variable "private_zone_id" {
  description = "The PHZ Zone ID in this account"
  type        = string
}
