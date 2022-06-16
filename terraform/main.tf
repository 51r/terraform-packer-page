terraform {
  required_providers {
    aws = {
      version = ">= 4.18.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.1.9"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name  = "test-vpc"
    email = var.email
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name  = "test-gateway"
    email = var.email
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr
  tags = {
    Name  = "test-subnet"
    email = var.email
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name  = "test-route_table"
    email = "spasov@hashicorp.com"
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_security_group" "sg_80" {
  name   = "test_sg80"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_public.id
  vpc_security_group_ids      = [aws_security_group.sg_80.id]
  associate_public_ip_address = true

  tags = {
    Name  = "test-ec2"
    email = var.email
  }
}

output "website_ip" {
  value = aws_instance.web.public_ip
}