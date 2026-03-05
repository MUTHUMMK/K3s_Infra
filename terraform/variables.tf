variable "name" {
    type = map(string)
    default = {
      "dev" = "K3s_dev_SG"
      "stag"= "K3s_stag_SG"
    }
}
variable "ami" {}
variable "instance_type" {
    type = map(string)
    default = {
      "dev" = "t2.medium"
      "stag"="t3.medium"
    }
}
variable "key_name" {}
variable "server_name" {
    type = map(string)
    default = {
      "dev" = "dev_server"
      "stag"= "stag_server"
    }
}

