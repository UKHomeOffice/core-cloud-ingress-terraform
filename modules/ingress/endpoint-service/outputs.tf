output "default" {
  value = {
    arn          = aws_vpc_endpoint_service.default.arn
    service_name = aws_vpc_endpoint_service.default.service_name
  }
}