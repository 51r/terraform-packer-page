packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
source "amazon-ebs" "ubuntu" {
  ami_name      = "page-ubuntu-aws"
  instance_type = "t2.micro"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
    tags = ["Peter-Test"]
    
  }
  ssh_username = "ubuntu"
}

build {
  name = "peter-test"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    script = "scripts/install.sh"
  }
}