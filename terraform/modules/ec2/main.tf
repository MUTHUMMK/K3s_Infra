

# provider "aws" {
#   region = "ap-south-1"
# }

# resource "aws_instance" "this" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   vpc_security_group_ids = [var.security_group]

#   tags = {
#     Name = var.name
#   }
# }



##############


provider "aws" {
  region = "ap-south-1"
}

locals {
  private_key_path="/home/ubuntu/.ssh/test.pem"
  package="/home/ubuntu/K3S/actions-runner/_work/K3s_Project/K3s_Project/ansible/playbook.yml"
  ssh_user="ubuntu"
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [var.security_group]

  tags = {
    Name = var.name
  }

  provisioner "remote-exec" {
    inline = [ "echo 'Wait until SSH is ready '" ]
    
    connection {
      type = "ssh"
      user = local.ssh_user
      private_key = file(local.private_key_path)
      host = aws_instance.this.public_ip
    }
  }

  provisioner "local-exec" {
    command = "sleep 20 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${aws_instance.this.public_ip}, --private-key ${local.private_key_path} ${local.package}" 
  }
}


