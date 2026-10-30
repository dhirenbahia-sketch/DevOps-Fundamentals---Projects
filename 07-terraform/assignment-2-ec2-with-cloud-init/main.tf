terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

#VPC resource block
resource "aws_vpc" "assignment2_vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true
}

#Internet Gateway resource block
resource "aws_internet_gateway" "assignment2_igw" {
  vpc_id = aws_vpc.assignment2_vpc.id
}

#Subnet resource block
resource "aws_subnet" "assignment2_subnet" {
  vpc_id                  = aws_vpc.assignment2_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
}

#Route Table resource block
resource "aws_route_table" "assignment2_route_table" {
  vpc_id = aws_vpc.assignment2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.assignment2_igw.id
  }
}

resource "aws_route_table_association" "assignment2_route_table_association" {
  subnet_id      = aws_subnet.assignment2_subnet.id
  route_table_id = aws_route_table.assignment2_route_table.id
}

resource "aws_security_group" "assignment2_sg" {
  name        = "assignment2_sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.assignment2_vpc.id

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
}

resource "aws_instance" "assignment2_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.assignment2_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.assignment2_sg.id]
  user_data = file("cloud-init.yaml")


 }