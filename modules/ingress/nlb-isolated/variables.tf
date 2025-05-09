variable "tags" {
  type        = map(string)
  description = "Tags to apply to AWS resources"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "public_subnet_filter" {
  type        = string
  description = "Name tag filter for public subnets"
}

variable "tenant" {
  description = "The tenant name"
  type        = string
}

variable "ingress_lb_group_name" {
  description = "Tag value used for Phoenix Lambda to locate NLB"
  type        = string
}

