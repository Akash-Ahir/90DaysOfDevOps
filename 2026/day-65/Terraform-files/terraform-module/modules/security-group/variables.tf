variable "vpc_id" {
  description = "VPC where the security group will be created"
  type = string
}

variable "sg_name" {
  description = "Name of the security group"
  type = string
}

variable "ingress_ports" {
  description = "Ports allowed for inbound traffic"
  type = list(number)
  default = [22, 80]
}

variable "tags" {
  description = "Tags for the security group"
  type = map(string)
  default = {}
}
