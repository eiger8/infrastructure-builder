module "env-network" {
  source = "./modules/network"
  env-name = var.env-name
  ip-allowed = var.ip-allowed
  region = var.region
  vpc-cidr = var.vpc-cidr
  zones = var.zones
  nat-instance-id = aws_instance.nat-bastion.id
}
provider "aws" {
  profile = "eiger"
  region = var.region
}
//T2 Micro instance. NAT Instance & Bastion Host.
resource "aws_instance" "nat-bastion" {
  ami = "ami-009816cdbb1e74ceb"
  instance_type = "t2.micro"
  key_name = var.ssh_key["name"]
  subnet_id = module.env-network.env-public-subnet-id[0]
  vpc_security_group_ids = [
    module.env-network.env-security-group-pub-id]
  source_dest_check = "false"
  tags = {
    Name = "NAT-Bastion ${var.env-name}"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.ssh_key["path"])
    host = self.public_dns
  }
}
resource "aws_instance" "regular-amz-t2micro" {
  ami = "ami-0a85857bfc5345c38"
  instance_type = "t2.micro"
  key_name = var.ssh_key["name"]
  subnet_id = module.env-network.env-private-subnet-id[0]
  vpc_security_group_ids = [
    module.env-network.env-security-group-priv-id]
  tags = {
    Name = "AMZ T2 Micro ${var.env-name}"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.ssh_key["path"])
    host = self.public_dns
  }
}