terraform {
  required_providers {
    aws = {
      version = ">= 4.18.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.1.9"
}

module "vpc" {
  source      = "./vpc"
  ami_id      = var.ami_id
  subnet_cidr = var.subnet_cidr
  email       = var.email
  name        = var.name
  vpc_cidr    = var.vpc_cidr
}

resource "aws_instance" "web" {
  depends_on                  = [module.vpc]
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.subnet
  vpc_security_group_ids      = [module.vpc.security_group]
  associate_public_ip_address = true

  tags = {
    Name  = "${var.name}-ec2"
    email = var.email
  }
}

output "website_ip" {
  value = aws_instance.web.public_ip
}