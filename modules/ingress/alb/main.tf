
output "workload_external_nlb_ips" {
  description = "List of External NLB IPs"
  value       = "${var.workload_external_nlb_ips}" 
}

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name_prefix = "${var.tenant}-external-${var.account_id}-"
  description = "Allow inbound traffic to ALB"

  vpc_id = data.aws_vpcs.filtered_vpcs.ids[0]

  ingress {
    description = "Allow traffic from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change as needed
  }

  egress {
    description = "Allow traffic from ALB to NLBs in workload accounts"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8","172.16.0.0/16"] # Adjust as per your VPC CIDR
  }
  
}

# Create ALB
resource "aws_lb" "tenant_alb" {
  name               = "${var.tenant}-external-${var.account_id}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.filtered_subnets.ids

  drop_invalid_header_fields = true  # Enable dropping invalid headers

  enable_deletion_protection = false
  
}

# Target Group using External NLB IPs without VPC association
resource "aws_lb_target_group" "tenant_target_group" {
  name        = "${var.tenant}-external-${var.account_id}-tg"
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"  # IP addresses can be from any network
  vpc_id      = data.aws_vpcs.filtered_vpcs.ids[0]  # Specify the VPC ID where the ALB exists

  health_check {
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTPS"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200,404"
  }

}

# Attach workload NLB IPs to the target group
resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each         = toset(jsondecode(var.workload_external_nlb_ips))
  target_group_arn = aws_lb_target_group.tenant_target_group.arn
  target_id        = each.value
  port             = 443
  availability_zone   = "all"  # To support external IPs
}

# HTTPS Listener using the ACM cert ARN from acm.tf output
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.tenant_alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tenant_target_group.arn
  }
}


# Wait for alb creation so that eni's can be fetched when ready
resource "time_sleep" "wait_60_seconds" {
  depends_on = [aws_lb.tenant_alb]
  create_duration = "60s"
}