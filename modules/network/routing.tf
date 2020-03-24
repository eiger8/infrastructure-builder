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
  count = length(var.zones)
  subnet_id = element(aws_subnet.env-public-subnet[*].id, count.index)
  route_table_id = aws_route_table.public-routing-table.id
}

//Prepare private routing
resource "aws_route_table" "private-routing-table" {
  vpc_id = aws_vpc.env-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = var.nat-instance-id
  }
  tags = {
    Name = "${var.env-name} Private Routing Table"
  }
}
resource "aws_route_table_association" "env-rta-priv" {
  count = length(var.zones)
  subnet_id = element(aws_subnet.env-private-subnet[*].id, count.index)
  route_table_id = element(aws_route_table.private-routing-table[*].id, count.index)
}

