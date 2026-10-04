# ============================================================
# Network outputs
# ============================================================

output "vpc_id" {
  description = "ID du VPC cree par Terraform"
  value       = aws_vpc.zabbix_vpc.id
}

output "subnet_id" {
  description = "ID du subnet public"
  value       = aws_subnet.public_subnet.id
}

output "admin_cidr" {
  description = "Adresse IP publique autorisee pour l'administration"
  value       = local.admin_cidr
}


# ============================================================
# Zabbix Server
# ============================================================

output "zabbix_server_public_ip" {
  description = "Adresse IP publique du serveur Zabbix"
  value       = aws_instance.zabbix_server.public_ip
}

output "zabbix_server_private_ip" {
  description = "Adresse IP privee du serveur Zabbix"
  value       = aws_instance.zabbix_server.private_ip
}


# ============================================================
# Linux Server
# ============================================================

output "linux_server_public_ip" {
  description = "Adresse IP publique du serveur Linux"
  value       = aws_instance.linux_server.public_ip
}

output "linux_server_private_ip" {
  description = "Adresse IP privee du serveur Linux"
  value       = aws_instance.linux_server.private_ip
}


# ============================================================
# Windows Server
# ============================================================

output "windows_server_public_ip" {
  description = "Adresse IP publique du serveur Windows"
  value       = aws_instance.windows_server.public_ip
}

output "windows_server_private_ip" {
  description = "Adresse IP privee du serveur Windows"
  value       = aws_instance.windows_server.private_ip
}

output "windows_instance_id" {
  description = "ID de l'instance Windows"
  value       = aws_instance.windows_server.id
}