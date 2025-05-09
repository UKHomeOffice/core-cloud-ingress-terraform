# Output subnet names and CIDRs
output "subnet_names_and_cidrs" {
  value = {
    subnet_a = {
      name = aws_subnet.subnet_a.tags["Name"]
      cidr = aws_subnet.subnet_a.cidr_block
    }
    subnet_b = {
      name = aws_subnet.subnet_b.tags["Name"]
      cidr = aws_subnet.subnet_b.cidr_block
    }
    subnet_c = {
      name = aws_subnet.subnet_c.tags["Name"]
      cidr = aws_subnet.subnet_c.cidr_block
    }
  }
}