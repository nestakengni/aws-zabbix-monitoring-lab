# ============================================================
# Detect current public IP
# ============================================================

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}

locals {
  admin_cidr = "${chomp(data.http.my_ip.response_body)}/32"
}


# ============================================================
# Zabbix Server Security Group
# ============================================================

resource "aws_security_group" "zabbix_server_sg" {
  name        = "Zabbix-Server-SG"
  description = "Security Group for Zabbix Server"
  vpc_id      = aws_vpc.zabbix_vpc.id

  # SSH administration
  ingress {
    description = "SSH from administrator IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.admin_cidr]
  }

  # Zabbix Agent monitoring 
  ingress {
    description = "Zabbix Agent monitoring"
    from_port   = 10050
    to_port     = 10050
    protocol    = "tcp"
    cidr_blocks = [var.subnet_cidr]
  }

  # Zabbix Web Interface
  ingress {
    description = "Zabbix Web HTTP from administrator IP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [local.admin_cidr]
  }

  # Zabbix Server / Active checks
  ingress {
    description = "Zabbix Server traffic from private subnet"
    from_port   = 10051
    to_port     = 10051
    protocol    = "tcp"
    cidr_blocks = [var.subnet_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Zabbix-Server-SG"
    Project = "AWS-Zabbix-Monitoring"
  }
}


# ============================================================
# Linux Server Security Group
# ============================================================

resource "aws_security_group" "linux_server_sg" {
  name        = "Linux-Server-SG"
  description = "Security Group for monitored Linux server"
  vpc_id      = aws_vpc.zabbix_vpc.id

  # SSH administration
  ingress {
    description = "SSH from administrator IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.admin_cidr]
  }

  # Zabbix Agent
  ingress {
    description = "Zabbix Agent traffic from private subnet"
    from_port   = 10050
    to_port     = 10050
    protocol    = "tcp"
    cidr_blocks = [var.subnet_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Linux-Server-SG"
    Project = "AWS-Zabbix-Monitoring"
  }
}


# ============================================================
# Windows Server Security Group
# ============================================================

resource "aws_security_group" "windows_server_sg" {
  name        = "Windows-Server-SG"
  description = "Security Group for monitored Windows server"
  vpc_id      = aws_vpc.zabbix_vpc.id

  # RDP administration
  ingress {
    description = "RDP from administrator IP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [local.admin_cidr]
  }
  ingress {
    description = "WinRM HTTPS from administrator IP"
    from_port   = 5986
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = [local.admin_cidr]
  }

  # Zabbix Agent
  ingress {
    description = "Zabbix Agent traffic from private subnet"
    from_port   = 10050
    to_port     = 10050
    protocol    = "tcp"
    cidr_blocks = [var.subnet_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Windows-Server-SG"
    Project = "AWS-Zabbix-Monitoring"
  }
}