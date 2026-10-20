variable "aws_region" {
  description = "AWS region for the Day 10 lab"
  type        = string
  default     = "ap-southeast-2"
}

variable "availability_zone" {
  description = "Availability Zone for the lab subnets"
  type        = string
  default     = "ap-southeast-2a"
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = "10.30.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR range for the public subnet"
  type        = string
  default     = "10.30.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR range for the private subnet"
  type        = string
  default     = "10.30.2.0/24"
}

variable "app_allowed_cidr" {
  description = "Public IPv4 CIDR permitted to access application port 8000"
  type        = string
}

