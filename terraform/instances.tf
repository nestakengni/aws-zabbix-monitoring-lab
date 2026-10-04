# ============================================================
# Latest Ubuntu 24.04 LTS AMI
# ============================================================

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


# ============================================================
# Latest Windows Server 2022 AMI
# ============================================================

data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


# ============================================================
# Zabbix Server
# ============================================================

resource "aws_instance" "zabbix_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.zabbix_instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.zabbix_server_sg.id]
  key_name                    = aws_key_pair.lab_key.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    encrypted   = true
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name    = "Zabbix-Server"
    Project = "AWS-Zabbix-Monitoring"
    Role    = "Monitoring"
  }
}


# ============================================================
# Linux Server
# ============================================================

resource "aws_instance" "linux_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.linux_instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.linux_server_sg.id]
  key_name                    = aws_key_pair.lab_key.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp3"
    volume_size = 12
    encrypted   = true
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name    = "Linux-Server"
    Project = "AWS-Zabbix-Monitoring"
    Role    = "Monitored-Host"
  }
}


# ============================================================
# Windows Server
# ============================================================

resource "aws_instance" "windows_server" {
  ami                         = data.aws_ami.windows.id
  instance_type               = var.windows_instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.windows_server_sg.id]
  key_name                    = aws_key_pair.lab_key.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp3"
    volume_size = 30
    encrypted   = true
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name    = "Windows-Server"
    Project = "AWS-Zabbix-Monitoring"
    Role    = "Monitored-Host"
  }
}