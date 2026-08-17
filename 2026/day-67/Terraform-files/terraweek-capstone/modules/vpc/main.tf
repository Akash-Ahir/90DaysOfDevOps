resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
    Project = var.project_name
    Environment = var.environment
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet"
    Project = var.project_name
    Environment = var.environment
    ManagedBy = "Terraform"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
    Project = var.project_name
    Environment = var.environment
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gateway.id
  }
  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
    Project = var.project_name
    Environment = var.environment
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "my_rt_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my_rt.id
}
