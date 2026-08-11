variable "ami_id" {
  description = "ami id of EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet for EC2 instance "
  type        = string
}

variable "security_group_ids" {
  description = "Security groups for EC2 instance"
  type        = list(string)
}

variable "instance_name" {
  description = "Name of EC2 instance"
  type        = string
}

variable "tags" {
  description = "Additional tags of EC2 instance"
  type        = map(string)
  default     = {}
}
