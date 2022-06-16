
variable "ami_id" {
  type        = string
  description = "Specify AMI ID output from Packer"
  default     = "ami-0e8040f700cdfdd53"
}

variable "subnet_cidr" {
  type        = string
  description = "Specify CIDR Block for Subnet"
  default     = "10.0.0.0/24"
}

variable "vpc_cidr" {
  type        = string
  description = "Specify CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "email" {
  type        = string
  description = "Specify the email for resource's tags"
  default     = "spasov@hashicorp.com"

}

variable "name" {
  type        = string
  description = "Specify the prefix name for the AWS resources"
  default     = "Peter"

}