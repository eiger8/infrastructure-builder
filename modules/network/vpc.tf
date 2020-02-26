provider "aws" {
  region = var.region
}
resource "aws_vpc" "env-vpc" {
  cidr_block = var.vpc-cidr
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
