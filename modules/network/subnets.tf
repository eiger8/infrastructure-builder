//Creating PUBLIC subnetworks, associate it's route table for inbound internet communication.
resource "aws_subnet" "env-public-subnet" {
  vpc_id = aws_vpc.env-vpc.id
  count = length(var.zones)
  cidr_block = cidrsubnet(var.vpc-cidr, 8, count.index)
  map_public_ip_on_launch = "true"
  availability_zone = element(var.zones, count.index)
  tags = {
    Name = "${var.env-name} Public Subnet"
  }
}

//Creating PRIVATE subnetworks
resource "aws_subnet" "env-private-subnet" {
  vpc_id = aws_vpc.env-vpc.id
  count = length(var.zones)
  cidr_block = cidrsubnet(var.vpc-cidr, 8, count.index + 1)
  map_public_ip_on_launch = "false"
  availability_zone = element(var.zones, count.index)
  tags = {
    Name = "${var.env-name} Private Subnet"
  }
}
