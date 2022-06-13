terraform {
  required_providers {
    aws = {
      version = ">= 4.18.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = "~> v1.1.9"
}

variable "ami_id" {
  type = string
}

resource "aws_security_group" "sg_80" {
  name = "peter_80"

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
  vpc_security_group_ids      = [aws_security_group.sg_80.id]
  associate_public_ip_address = true

  tags = {
    Name  = "Peter-Test"
    email = "spasov@hashicorp.com"
  }
}

output "website_ip" {
  value = aws_instance.web.public_ip
}