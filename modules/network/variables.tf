variable "region" {
  default = "us-west-2"
}
variable "ssh_key" {
  type = map(string)
  default = {
    "name" = "devops-cluster"
    "path" = "~/.devops-cluster.pem"
  }
}
variable "env-name" {
  default = "Env-Network"
}

variable "ip-ranges" {
  type = map(string)
  default = {
    "public-subnet" = "10.10.10.0/24"
    "private-subnet" = "10.10.14.0/24"
    "inbound-fw-1" = "213.109.239.143/32"
    "inbound-fw-2" = "185.112.0.0/16"
  }
}
