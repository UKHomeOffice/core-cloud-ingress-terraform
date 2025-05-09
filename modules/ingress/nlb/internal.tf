
# Internal NLB
resource "aws_lb" "internal_nlb" {
  name               = "${var.ingress_lb_group_name}-internal"
  internal           = true
  load_balancer_type = "network"
  enable_deletion_protection = false


  subnet_mapping {
    subnet_id     = data.aws_subnets.filtered_subnets.ids[0]
  }

  subnet_mapping {
    subnet_id     = data.aws_subnets.filtered_subnets.ids[1]
      }

  subnet_mapping {
    subnet_id     = data.aws_subnets.filtered_subnets.ids[2]
  }

  # Attach the security group
  security_groups = [aws_security_group.internal_nlb_sg.id]

  tags = merge(
    var.tags,
    {
      "eks_ingress_lb_group_name" = "${var.ingress_lb_group_name}-internal"
    }
  )
}


resource "aws_security_group" "internal_nlb_sg" {
  name        = "${var.tenant}-internal-sg"
  description = "Security group for internal NLB"
  vpc_id      = data.aws_vpcs.filtered_vpcs.ids[0]

  # Allow traffic from the VPC for internal communication
  ingress {
    description = "Allow traffic from private subnets"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8"] # Adjust as per your VPC CIDR
  }

  # Allow traffic from other instances using the same security group
  ingress {
    description = "Allow traffic from NLB for health checks"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    self        = true
  }

  # Allow all egress traffic
  egress {
    description = "Allow Outbound traffic from NLB"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.tenant}-internal-sg"
    }
  )
}
