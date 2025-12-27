### VPC ######
resource "aws_vpc" "pmapp_vpc" {
  cidr_block           = "10.40.0.0/24"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "pmapp_vpc"
  }
}

### Internet Gateway for VPC ######
resource "aws_internet_gateway" "pmapp_vpc_igw" {
  vpc_id = aws_vpc.pmapp_vpc.id

  tags = {
    Name = "pmapp_vpc_igw"
  }
}

### Routing Table for Public Subnet ######
resource "aws_route_table" "pmapp_public_rt" {
  vpc_id = aws_vpc.pmapp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pmapp_vpc_igw.id
  }
}

### Create public subnet ######
resource "aws_subnet" "pmapp_public_subnet_1a" {
  vpc_id                  = aws_vpc.pmapp_vpc.id
  cidr_block              = "10.40.0.0/26"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "pmapp_public_subnet-1a"
  }
}

### Association of igw --> subnet ###
resource "aws_route_table_association" "pmapp_public_rt_assoc_1a" {
  subnet_id      = aws_subnet.pmapp_public_subnet_1a.id
  route_table_id = aws_route_table.pmapp_public_rt.id
} 