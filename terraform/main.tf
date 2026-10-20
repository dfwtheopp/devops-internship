terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Create a separate VPC for the Day 10 exercise.
resource "aws_vpc" "devops_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "devops-day10-vpc"
  }
}

# Create the public subnet.
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "devops-day10-public-subnet"
  }
}

# Create the private subnet.
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "devops-day10-private-subnet"
  }
}

# Attach an Internet Gateway to the VPC.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "devops-day10-igw"
  }
}

# Create the public route table.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "devops-day10-public-rt"
  }
}

# Associate the public route table with the public subnet.
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create the private route table without a default internet route.
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "devops-day10-private-rt"
  }
}

# Associate the private route table with the private subnet.
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Allow approved traffic to reach the application on port 8000.
resource "aws_security_group" "app" {
  name        = "devops-day10-app-sg"
  description = "Allow application traffic from an approved CIDR"
  vpc_id      = aws_vpc.devops_vpc.id

  ingress {
    description = "Application port"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [var.app_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-day10-app-sg"
  }
}

# Allow PostgreSQL traffic only from the application security group.
resource "aws_security_group" "db" {
  name        = "devops-day10-db-sg"
  description = "Allow PostgreSQL traffic from the application security group"
  vpc_id      = aws_vpc.devops_vpc.id

  ingress {
    description     = "PostgreSQL from application security group"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-day10-db-sg"
  }
}