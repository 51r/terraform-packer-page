variable "ami_id" {
  type    = string
  default = "ami-0e8040f700cdfdd53"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"

}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"

}

variable "email" {
  type    = string
  default = "spasov@hashicorp.com"

}