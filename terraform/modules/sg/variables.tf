variable "name" {}

variable "ingress_rules" {
  type = list(object({
    port     = number
    protocol = string
    cidr     = list(string)
  }))
}