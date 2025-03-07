resource "aws_vpc" "basic_net" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.vpc_tags
}

resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.basic_net.id
  availability_zone       = element(var.zone, 0)
  cidr_block              = "192.168.0.0/26"
  map_public_ip_on_launch = true
  tags                    = var.subnet_tags
}

resource "aws_subnet" "pub2" {
  vpc_id                  = aws_vpc.basic_net.id
  availability_zone       = element(var.zone, 1)
  cidr_block              = "192.168.0.64/26"
  map_public_ip_on_launch = true
  tags = {
    Name        = "pub_2"
    environment = "dev"
  }
}

resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.basic_net.id
  availability_zone       = element(var.zone, 2)
  cidr_block              = "192.168.0.128/26"
  map_public_ip_on_launch = false
  tags = {
    Name        = "private_1"
    environment = "dev"
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.basic_net.id
  availability_zone       = element(var.zone, 3)
  cidr_block              = "192.168.0.192/26"
  map_public_ip_on_launch = false
  tags = {
    Name        = "private_2"
    environment = "dev"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.basic_net.id
  tags = {
    Name        = "igw"
    environment = "dev"
  }
}

resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.basic_net.id
  route {
    cidr_block = var.internet_ip
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_route_table_association" "pubrt-ass1" {
  route_table_id = aws_route_table.pubrt.id
  subnet_id      = aws_subnet.pub1.id
}

resource "aws_route_table_association" "pubrt-ass2" {
  route_table_id = aws_route_table.pubrt.id
  subnet_id      = aws_subnet.pub2.id
}

resource "aws_route_table" "prirt" {
  vpc_id = aws_vpc.basic_net.id
}

resource "aws_route_table_association" "prirt-ass1" {
  route_table_id = aws_route_table.prirt.id
  subnet_id      = aws_subnet.private1.id
}

resource "aws_route_table_association" "prirt-ass2" {
  route_table_id = aws_route_table.prirt.id
  subnet_id      = aws_subnet.private2.id
}

