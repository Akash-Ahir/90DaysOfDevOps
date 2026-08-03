# region

variable "region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"

}

# vpc_cidr

variable "vpc_cidr" {
  description = "cidr block for vpc"
  type = string
  default = "10.0.0.0/16"

}

# subnet cidr

variable "subnet_cidr" {
  description = "cidr block of subnet"
  type = string
  default = "10.0.1.0/24"
}

# instance_type

variable "instance_type" {
  description = "AWS instance type "
  type = string
  default = "t3.micro"

}

# project_name

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

# allowed port

variable "allowed_ports" {
  description = "Allowed Ports"
  type        = list(number)

  default = [22,80,443]
}


variable "extra_tags" {
  description = "Tags"
  type = map(string)
  default = {}
}
