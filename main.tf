module "env-network" {
  source = "./modules/network"
  env-name = var.env-name
  ip-allowed = var.ip-allowed
//  private-subnet = var.private-subnet
//  public-subnet = var.public-subnet
  region = var.region
  vpc-cidr = var.vpc-cidr
  zones = var.zones
}
provider "aws" {
  region = var.region
}
//T2 Micro instance. NAT Instance & Bastion Host.
resource "aws_instance" "nat-bastion" {
  count = length(var.zones)
  ami = "ami-009816cdbb1e74ceb"
  instance_type = "t2.micro"
  key_name = var.ssh_key["name"]
  subnet_id = element(module.env-network.env-private-subnet-id[*], count.index)
  vpc_security_group_ids = [module.env-network.env-security-group-pub-id]
  source_dest_check = "false"
  tags = {
    Name = "NAT-Bastion ${var.env-name}"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file(var.ssh_key["path"])
    host     = self.public_dns
  }
}
resource "aws_instance" "instance-vulgaris" {
  count = length(var.zones)
  ami = "ami-0a85857bfc5345c38"
  instance_type = "t2.micro"
  key_name = var.ssh_key["name"]
  subnet_id = element(module.env-network.env-private-subnet-id[*], count.index)
  vpc_security_group_ids = [module.env-network.env-security-group-priv-id]
  tags = {
    Name = "AMZ Vulgaris ${var.env-name}"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file(var.ssh_key["path"])
    host     = self.public_dns
  }
}