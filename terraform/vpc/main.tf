variable "ami_id" {
  type        = string
  description = "Specify AMI ID output from Packer"
}

variable "subnet_cidr" {
  type        = string
  description = "Specify CIDR Block for Subnet"
}

variable "vpc_cidr" {
  type        = string
  description = "Specify CIDR block for VPC"
}

variable "email" {
  type        = string
  description = "Specify the email for resource's tags"
}

variable "name" {
  type        = string
  description = "Specify the prefix name for the AWS resources"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name  = "${var.name}-vpc"
    email = var.email
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name  = "${var.name}-gateway"
    email = var.email
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr
  tags = {
    Name  = "${var.name}-subnet"
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
    Name  = "${var.name}-route_table"
    email = var.email
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_security_group" "sg_80" {
  name   = "${var.name}_sg80"
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


output "subnet" {
  value = aws_subnet.subnet_public.id
}

output "aws_vpc" {
  value = aws_vpc.vpc.id
}

output "security_group" {
  value = aws_security_group.sg_80.id
}