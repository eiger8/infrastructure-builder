resource "aws_subnet" "env-public-subnet" {
  vpc_id = aws_vpc.env-vpc.id
  cidr_block = var.ip-ranges["public-subnet"]
  map_public_ip_on_launch = "true"
  availability_zone = "us-west-2b"
  tags = {
    Name = "${var.env-name} Public Subnet"
  }
}
/*
resource "aws_subnet" "env-private-subnet" {
  vpc_id = aws_vpc.env-vpc.id
  cidr_block = var.ip-ranges["public-subnet"]
  map_public_ip_on_launch = "false"
  availability_zone = "us-west-2b"
  tags = {
    Name = "${var.env-name} Private Subnet"
  }
}*/
