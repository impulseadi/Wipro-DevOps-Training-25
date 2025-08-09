# aws provider configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "sa-east-1"
}


# aws ec2 instance provisoning

resource "aws_instance" "web" {
  ami           = "ami-0a174b8e659123575"
  instance_type = "t2.small"

  tags = {
    Name = "murali-vm"
  }
}
