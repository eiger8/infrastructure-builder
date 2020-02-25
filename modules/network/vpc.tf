resource "aws_vpc" "env-vpc" {
  cidr_block = var.ip-ranges["public-subnet"]
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  instance_tenancy = "default"
  tags = {
    Name = "${var.env-name} VPC"
  }
}
resource "aws_internet_gateway" "env-igw" {
  vpc_id = aws_vpc.env-vpc.id
  tags = {
    Name = "${var.env-name} Internet GW"
  }
}
resource "aws_route_table" "public-routing-table" {
  vpc_id = aws_vpc.env-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.env-igw.id
  }
  tags = {
    Name = "${var.env-name} Public Routing Table"
  }
}
resource "aws_route_table_association" "env-rta" {
  subnet_id = aws_subnet.env-public-subnet.id
  route_table_id = aws_route_table.public-routing-table.id
}