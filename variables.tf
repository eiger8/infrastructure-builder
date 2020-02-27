variable "region" {
  default = "us-west-2"
}
variable "zones" {
  type = list(string)
  default = [
    "us-west-2a",
    "us-west-2b",
    "us-west-2c",
  ]
}
variable "env-name" {
  default = "Env-Network"
}
variable "ssh_key" {
  type = map(string)
  default = {
    "name" = "devops-cluster"
    "path" = "~/.devops-cluster.pem"
  }
}
variable "vpc-cidr" {
  default = "10.0.0.0/16"
}
variable "ip-allowed" {
  type = map(string)
  default = {
    "inbound-fw-1" = "213.109.239.143/32"   //Private network
    "inbound-fw-2" = "185.112.0.0/16"       //Softserve subnet
  }
}