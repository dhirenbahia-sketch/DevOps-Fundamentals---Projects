variable "aws_region" {
   description = "The AWS region to deploy resources in"
   type        = string
   default     = "us-east-1"
}

variable "instance_type" {
   description = "The EC2 instance type for my WordPress server"
   type        = string
   default     = "t2.micro"
}
variable "VPC_CIDR" {
   description = "The CIDR block for the VPC"
   type        = string
   default     = "10.0.0.0/16"
}
variable "subnet_cidr" {
   description = "The CIDR block for the subnet"
   type        = string
   default     = "10.0.0.0/24"
}
variable "ami_id" {
   description = "The AMI ID for the EC2 instance"
   type        = string
   default     = "ami-0567589d25e06853e" # Example AMI ID, replace with a valid one for your region
} 