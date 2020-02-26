//Prepare public routing
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
resource "aws_route_table_association" "env-rta-pub" {
  subnet_id = aws_subnet.env-public-subnet.id
  route_table_id = aws_route_table.public-routing-table.id
}

//Prepare private routing
resource "aws_route_table" "private-routing-table" {
  vpc_id = aws_vpc.env-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "${var.env-name} Private Routing Table"
  }
}
resource "aws_route_table_association" "env-rta-priv" {
  subnet_id = aws_subnet.env-private-subnet.id
  route_table_id = aws_route_table.private-routing-table.id
}

