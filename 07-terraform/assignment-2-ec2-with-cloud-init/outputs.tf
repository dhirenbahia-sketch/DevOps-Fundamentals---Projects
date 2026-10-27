output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.assignment2_vpc.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.assignment2_subnet.id
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.assignment2_ec2.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.assignment2_sg.id
}


output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.assignment2_ec2.public_ip
}

output "dns_name" {
  description = "The DNS name of the EC2 instance"
  value       = aws_instance.assignment2_ec2.public_dns
}

output "website_url" {
  description = "The URL of the website"
  value       = "http://${aws_instance.assignment2_ec2.public_ip}"
}
