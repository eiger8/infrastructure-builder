//VPC resource related data
output "env-vpc-id" {
  value = aws_vpc.env-vpc.id
}
output "env-vpc-cidr" {
  value = aws_vpc.env-vpc.cidr_block
}

//Subnets relates data
output "env-public-subnet-id" {
  value = aws_subnet.env-public-subnet[*].id
}
output "env-public-subnet-cidr" {
  value = aws_subnet.env-public-subnet[*].cidr_block
}
output "env-private-subnet-id" {
  value = aws_subnet.env-private-subnet[*].id
}
output "env-private-subnet-cidr" {
  value = aws_subnet.env-private-subnet[*].cidr_block
}

//Security groups related data
output "env-security-group-pub-id" {
  value = aws_security_group.env-security-group-pub.id
}
output "env-security-group-priv-id" {
  value = aws_security_group.env-security-group-priv.id
}

