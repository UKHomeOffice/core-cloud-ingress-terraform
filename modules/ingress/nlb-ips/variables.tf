
variable "tenant" {
  description = "The tenant name"
  type        = string
}

# Define the variable
variable "apply_only" {
  type    = bool
  default = false
}

variable "ingress_lb_group_name" {
  description = "Ingress LB tag name"
  type        = string
}
