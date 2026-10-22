output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.example.id
}
output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.example.id
}
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.wordpress.id
}
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.wordpress.public_ip
}

output "dns_name" {
  description = "The DNS name of the EC2 instance"
  value       = aws_instance.wordpress.public_dns
}
output "website_url" {
  description = "The URL of the WordPress website"
  value       = "http://${aws_instance.wordpress.public_dns}"
}
