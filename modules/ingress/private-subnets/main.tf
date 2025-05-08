# Fetch VPC ID based on its Name tag
data "aws_vpcs" "filtered_vpcs" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_vpc" "selected" {
  id = data.aws_vpcs.filtered_vpcs.ids[0]
}

# Create Subnet in Availability Zone A
resource "aws_subnet" "subnet_a" {
  vpc_id            = data.aws_vpc.selected.id
  cidr_block        = cidrsubnet(data.aws_vpc.selected.cidr_block, 3, 5)  # x.x.x.160/27
  availability_zone = "eu-west-2a"

  tags = merge({
    Name = "${var.vpc_name}-private-main-subnet-a"
  }, var.tags)
}

# Create Subnet in Availability Zone B
resource "aws_subnet" "subnet_b" {
  vpc_id            = data.aws_vpc.selected.id
  cidr_block        = cidrsubnet(data.aws_vpc.selected.cidr_block, 3, 6)  # x.x.x.192/27
  availability_zone = "eu-west-2b"

  tags = merge({
    Name = "${var.vpc_name}-private-main-subnet-b"
  }, var.tags)
}

# Create Subnet in Availability Zone C
resource "aws_subnet" "subnet_c" {
  vpc_id            = data.aws_vpc.selected.id
  cidr_block        = cidrsubnet(data.aws_vpc.selected.cidr_block, 3, 7)  # x.x.x.224/27
  availability_zone = "eu-west-2c"

  tags = merge({
    Name = "${var.vpc_name}-private-main-subnet-c"
  }, var.tags)
}


