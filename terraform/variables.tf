
# Specify AMI ID output from Packer
variable "ami_id" {
  type    = string
  default = "ami-0e8040f700cdfdd53"
}

# Specify CIDR Block for Subnet
variable "subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"

}

# Specify CIDR block for VPC
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"

}

# Specify the email for resource's tags
variable "email" {
  type    = string
  default = "spasov@hashicorp.com"

}

# Specify the prefix name for the AWS resources
variable "name" {
  type = string
  default = "Peter"
  
}