# ============================================================
# VPC
# ============================================================

resource "aws_vpc" "zabbix_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "Zabbix-VPC"
    Project = "AWS-Zabbix-Monitoring"
  }
}


# ============================================================
# Public Subnet
# ============================================================

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.zabbix_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name    = "Zabbix-Public-Subnet"
    Project = "AWS-Zabbix-Monitoring"
  }
}


# ============================================================
# Internet Gateway
# ============================================================

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.zabbix_vpc.id

  tags = {
    Name    = "Zabbix-IGW"
    Project = "AWS-Zabbix-Monitoring"
  }
}


# ============================================================
# Public Route Table
# ============================================================

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.zabbix_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "Zabbix-Public-Route-Table"
    Project = "AWS-Zabbix-Monitoring"
  }
}


# ============================================================
# Associate Route Table with Subnet
# ============================================================

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


# ============================================================
# SSH Key Pair
# ============================================================

resource "aws_key_pair" "lab_key" {
  key_name   = "zabbix-lab-terraform-key"
  public_key = file(pathexpand("~/.ssh/zabbix-lab-key.pub"))

  tags = {
    Project = "AWS-Zabbix-Monitoring"
  }
}