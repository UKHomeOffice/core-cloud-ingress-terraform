# Define the variable
variable "apply_only" {
  type    = bool
  default = false
}

variable "ingress_lb_group_name" {
  description = "Ingress LB tag name"
  type        = string
}

variable "external_ingress" {
  type        = bool
  description = "Whether to create external NLB + SG + rules"
  default     = false
}