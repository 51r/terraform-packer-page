variable "ami_id" {
  type        = string
  description = "Specify AMI ID output from Packer"
}

variable "email" {
  type        = string
  description = "Specify the email for resource's tags"
}

variable "name" {
  type        = string
  description = "Specify the prefix name for the AWS resources"
}

variable "subnet" {

}

variable "security_group" {

}


resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet
  vpc_security_group_ids      = [var.security_group]
  associate_public_ip_address = true

  tags = {
    Name  = "${var.name}-ec2"
    email = var.email
  }
}


output "public_ip" {
  value = aws_instance.web.public_ip
}