# vpc variables

variable "cidr_block_vpc" {
  description = "cidr block for vpc"
}

variable "instance_tenancy" {
  description = "vpc tenancy"
}

variable "Name_vpc" {
  description = "vpc name"
}

# subnet variables

variable "cidr_block_subnet" {
  description = "subnet cidr block"
}

variable "availability_zone_pub_subnet" {
  description = "subnet availability zone"
}

variable "Name_subnet" {
  description = "subnet name"
}