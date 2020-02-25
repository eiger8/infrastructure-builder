provider "aws" {
  region = var.region
  profile = "default"
  # access_key = var.creds[access_key]
  # secret_key = var.creds[secret_key]
}

##################################################################
# T2 Micro Instance creation and provisioning
##################################################################
resource "aws_instance" "jenkins-env" {
  ami = "ami-0a85857bfc5345c38"
  instance_type = "t2.micro"
  key_name = var.ssh_key["name"]
  subnet_id = aws_subnet.ci-subnet.id
  vpc_security_group_ids = [aws_security_group.ci-sec-group.id]
  tags = {
    Name = "jenkins-env"
  }
  #   provisioner "local-exec" {
  #     command = "echo ${aws_instance.jenkins-env.public_ip} > ip_address.txt"
  #   }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file(var.ssh_key["path"])
    host     = self.public_dns
  }
  provisioner "file" {
    source      = "jenkins-install.sh"
    destination = "/tmp/jenkins-install.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/jenkins-install.sh",
      "cd /tmp && ./jenkins-install.sh"
    ]
  }
  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${var.ssh_key["path"]} ec2-user@${aws_instance.jenkins-env.public_dns}:/var/lib/jenkins/secrets/initialAdminPassword ~/"
  }
}