# Outputs print useful information after terraform apply finishes
# Like a summary of what was created

output "vpc_id" {
  description = "The ID of the VPC we created"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.main.id
}
