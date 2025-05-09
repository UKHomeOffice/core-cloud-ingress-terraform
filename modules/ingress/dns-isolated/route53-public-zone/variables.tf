
variable "hosted_zone_id" {
  description = "Workload account hosted zone id"
  type        = string
  default     = ""
}



variable "domain_name" {
  description = "The domain name for the Route 53 record"
  type        = string
}

variable "nlb_name" {
  description = "nlb name"
  type        = string
}


variable "nlb_zone" {
  description = "nlb dns zone"
  type        = string
}
