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
    values = [var.private_subnet_filter]
  }

  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.filtered_vpcs.ids
  }
}

output "vpc_id" {
  value = data.aws_vpcs.filtered_vpcs.ids[0]
}

output "private_subnets" {
  value = data.aws_subnets.filtered_subnets.ids
}


