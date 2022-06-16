terraform {
  required_providers {
    aws = {
      version = ">= 4.18.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.1.9"
}


module "network" {
  source      = "./network"
  subnet_cidr = var.subnet_cidr
  email       = var.email
  name        = var.name
  vpc_cidr    = var.vpc_cidr
}

module "app" {
  source         = "./app"
  depends_on     = [module.network]
  ami_id         = var.ami_id
  name           = var.name
  email          = var.email
  subnet         = module.network.subnet
  security_group = module.network.security_group
}


output "website_ip" {
  value = module.app.public_ip
}