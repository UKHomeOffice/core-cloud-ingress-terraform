# external NLB
resource "aws_lb" "external_nlb" {
  name               = "${var.ingress_lb_group_name}-external"
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
  security_groups = [aws_security_group.external_nlb_sg.id]

  tags = merge(
    var.tags,
    {
      "ingress_lb_group_name" = "${var.ingress_lb_group_name}-external"
    }
  )
}


resource "aws_security_group" "external_nlb_sg" {
  name        = "${var.tenant}-external-sg"
  description = "Security group for external NLB"
  vpc_id      = data.aws_vpcs.filtered_vpcs.ids[0]

  # Allow traffic from the VPC for external communication
  ingress {
    description = "Allow traffic from private subnets"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8","172.16.0.0/16"] # Adjust as per your VPC CIDR
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
    cidr_blocks = ["10.0.0.0/8","172.16.0.0/16"] # Adjust as per your VPC CIDR
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.tenant}-external-sg"
    }
  )
}

# Wait for after nlb creation so that eni's can be fetched when ready
resource "time_sleep" "wait_30_seconds" {
  depends_on = [aws_lb.external_nlb]
  create_duration = "30s"
}