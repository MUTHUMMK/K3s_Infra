
module "sg" {
  source = "./modules/sg"

  name = lookup(var.name, terraform.workspace, "DEFAULT_SG")

  ingress_rules = [
    {
      port     = 22
      protocol = "tcp"
      cidr     = ["0.0.0.0/0"]
    },
    {
      port     = 80
      protocol = "tcp"
      cidr     = ["0.0.0.0/0"]
    },
    {
      port     = 6443
      protocol = "tcp"
      cidr     = ["0.0.0.0/0"]
    }
  ]
}

module "ec2" {
  source = "./modules/ec2"

  name           = lookup(var.server_name, terraform.workspace, "DEFAULT")
  ami            = var.ami
  instance_type  = lookup(var.instance_type, terraform.workspace, "t2.micro")
  key_name       = var.key_name
  security_group = module.sg.security_group_id
}