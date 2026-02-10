

############################################
# External NLB (created only if external_ingress = true)
############################################
resource "aws_lb" "external_nlb" {
  count                      = var.external_ingress ? 1 : 0
  name                       = "${var.ingress_lb_group_name}-external"
  internal                   = true
  load_balancer_type         = "network"
  enable_deletion_protection = false

  subnet_mapping {
    subnet_id = data.aws_subnets.filtered_subnets.ids[0]
  }

  subnet_mapping {
    subnet_id = data.aws_subnets.filtered_subnets.ids[1]
  }

  subnet_mapping {
    subnet_id = data.aws_subnets.filtered_subnets.ids[2]
  }

  # Attach the security group
  security_groups = [aws_security_group.external_nlb_sg[0].id]

  tags = merge(
    var.tags,
    {
      ingress_lb_group_name = "${var.ingress_lb_group_name}-external"
    }
  )
}

############################################
# Security Group (no inline ingress/egress)
############################################
resource "aws_security_group" "external_nlb_sg" {
  count       = var.external_ingress ? 1 : 0
  name        = var.tenant == "" ? "ingress-external-sg" : "${var.tenant}-external-sg"
  description = "Security group for external NLB"
  vpc_id      = data.aws_vpcs.filtered_vpcs.ids[0]

  tags = merge(
    var.tags,
    {
      Name = var.tenant == "" ? "ingress-external-sg" : "${var.tenant}-external-sg"
    }
  )
}

############################################
# Ingress: allow 443 from private ranges
############################################
resource "aws_vpc_security_group_ingress_rule" "external_allow_443_from_10" {
  count             = var.external_ingress ? 1 : 0
  security_group_id = aws_security_group.external_nlb_sg[0].id

  description = "Allow traffic from private subnets"
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_ipv4   = "10.0.0.0/8"
}

resource "aws_vpc_security_group_ingress_rule" "external_allow_443_from_172_16" {
  count             = var.external_ingress ? 1 : 0
  security_group_id = aws_security_group.external_nlb_sg[0].id

  description = "Allow traffic from private subnets"
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_ipv4   = "172.16.0.0/16"
}

############################################
# Ingress: allow 443 from self (health checks)
############################################
resource "aws_vpc_security_group_ingress_rule" "external_allow_443_from_self" {
  count             = var.external_ingress ? 1 : 0
  security_group_id = aws_security_group.external_nlb_sg[0].id

  description = "Allow traffic from NLB for health checks"
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  referenced_security_group_id = aws_security_group.external_nlb_sg[0].id
}

############################################
# Egress: allow all protocols/ports to private ranges
############################################
resource "aws_vpc_security_group_egress_rule" "external_egress_all_to_10" {
  count             = var.external_ingress ? 1 : 0
  security_group_id = aws_security_group.external_nlb_sg[0].id

  description = "Allow Outbound traffic from NLB"
  ip_protocol = "-1"
  cidr_ipv4   = "10.0.0.0/8"
}

resource "aws_vpc_security_group_egress_rule" "external_egress_all_to_172_16" {
  count             = var.external_ingress ? 1 : 0
  security_group_id = aws_security_group.external_nlb_sg[0].id

  description = "Allow Outbound traffic from NLB"
  ip_protocol = "-1"
  cidr_ipv4   = "172.16.0.0/12"
}


