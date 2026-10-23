output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.wordpress_vpc.id
}
output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.wordpress_subnet.id
}
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.wordpress_ec2.id
}
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.wordpress_ec2.public_ip
}

output "dns_name" {
  description = "The DNS name of the EC2 instance"
  value       = aws_instance.wordpress_ec2.public_ip
}
output "website_url" {
  description = "The URL of the WordPress website"
  value       = "http://${aws_instance.wordpress_ec2.public_ip}"
}
