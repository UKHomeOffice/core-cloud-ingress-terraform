# Fetch VPC ID based on its Name tag
data "aws_vpcs" "filtered_vpcs" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Fetch private subnets based on the Name tag
data "aws_subnets" "filtered_subnets" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_filter]
  }

  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.filtered_vpcs.ids
  }
}

data "aws_lb_hosted_zone_id" "main" {}




