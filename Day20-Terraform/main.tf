# Create aws vpc

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "murali-vpc"
  }
}

# create aws public subnet

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "murali-public-subnet"
  }
}

# create aws private subnet

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "murali-private-subnet"
  }
}

# create internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "murali-IGW"
  }
}

# create a public route table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "murali-pub-RT"
  }
}

# associate route table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create elastic ip address

resource "aws_eip" "lb" {
  domain   = "vpc"

  tags = {
    Name= "murali-EIP"
  }
}

# Create NAT gateway

resource "aws_nat_gateway" "example" {
  subnet_id     = aws_subnet.public.id
  allocation_id = aws_eip.lb.id

  tags = {
    Name = "Murali-NAT-GW"
  }
}

# create a private route table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = "murali-pvt-RT"
  }
}

# associate route table

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}