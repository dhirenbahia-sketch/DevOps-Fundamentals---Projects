terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}


# Create a VPC
resource "aws_vpc" "wordpress_vpc" {
  cidr_block = var.VPC_CIDR
}

#Create an IGW
resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress_vpc.id
}

# Create a Subnet
resource "aws_subnet" "wordpress_subnet" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true
}

#Create AWS Route Table
resource "aws_route_table" "wordpress_route_table" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }
}  

# Associate AWS Route Table with Subnet
resource "aws_route_table_association" "wordpress_route_table_association" {
  subnet_id      = aws_subnet.wordpress_subnet.id
  route_table_id = aws_route_table.wordpress_route_table.id
}

# Create a Security Group
resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress_sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

# Creating the EC2 Instance Block"

