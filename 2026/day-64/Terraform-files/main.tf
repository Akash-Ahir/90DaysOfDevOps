# key

resource aws_key_pair my_key_pair {
  key_name = "terra-key"
  public_key = file("terra-worker.pub")
}

# vpc

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(
  local.common_tags,
    {
    Name = "${local.name_prefix}-vpc"

  }
)
}


#Fetch availability zone
data "aws_availability_zones" "availability_zone" {
  state = "available"
}

# subnet

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.availability_zone.names[0]

  tags = merge(local.common_tags,

    {
    Name = "${local.name_prefix}-subnet"
  }
)
}
# internet gateway

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "TerraWeek-internet-gateway"
  }
}

# route table

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "TerraWeek-Route-table"
  }
}

# route table association

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id

}

# security group

resource "aws_security_group" "my_security_group" {
  name = "terra-security-gruop"
  vpc_id = aws_vpc.my_vpc.id
  description = "security group created by terraform"
}

# inbound & outbond rule

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}


# Data Source

data "aws_ami" "ami" {
  most_recent = true
  owners       = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
}

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


# aws instance

resource "aws_instance" "my_server" {
  # ami           = "ami-0b826bb6d96d2afe4"
  ami = data.aws_ami.ami.id
  instance_type = var.environment == "prod" ? "t3.small" : "t3.micro"
  key_name = aws_key_pair.my_key_pair.key_name
  subnet_id = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  associate_public_ip_address = true
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-server"
    Owner       = "Akash"
  }
)
  lifecycle {
      create_before_destroy = true
}
}

# s3 bucket

resource "aws_s3_bucket" "terra_worker_bucket" {
        bucket = "akashahir-s3-bucket"
        depends_on = [aws_instance.my_server]

}

locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


resource "aws_s3_bucket" "logs_bucket" {
 bucket = "terraweek-import-test-akash"
}
