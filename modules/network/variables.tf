variable "region" {}
variable "env-name" {}
variable "vpc-cidr" {}
variable "public-subnet" {}
variable "private-subnet" {}
variable "ip-allowed" {type = map(string)}