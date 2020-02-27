variable "region" {}
variable "zones" {}
variable "env-name" {}
variable "vpc-cidr" {}
variable "ip-allowed" {type = map(string)}
variable "nat-instance-id" {}