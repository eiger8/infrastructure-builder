//Creating PUBLIC subnetworks, associate it's route table for inbound internet communication.
resource "aws_subnet" "env-public-subnet" {
  vpc_id = aws_vpc.env-vpc.id
  cidr_block = var.public-subnet //TODO replace with proper function
  map_public_ip_on_launch = "true"
  availability_zone = "us-west-2b"
  tags = {
    Name = "${var.env-name} Public Subnet" //TODO put counter for multiple resources
  }
}

//Creating PRIVATE subnetworks
resource "aws_subnet" "env-private-subnet" {
  vpc_id = aws_vpc.env-vpc.id
  cidr_block = var.private-subnet //TODO replace with proper function
  map_public_ip_on_launch = "false"
  availability_zone = "us-west-2b"
  tags = {
    Name = "${var.env-name} Private Subnet" //TODO put counter for multiple resources
  }
}
