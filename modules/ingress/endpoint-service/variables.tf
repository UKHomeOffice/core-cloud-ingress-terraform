variable "acceptance_required" {
  type    = bool
  default = true
}

variable "allowed_principals" {
  type    = set(string)
  default = []
}

variable "network_load_balancer_arns" {
  type    = set(string)
}

variable "principal_arns" {
  type    = set(string)
  default = []
}

variable "private_dns_name" {
  type    = string
  default = null
}

variable "private_dns_verification" {
  type    = bool
  default = false
}