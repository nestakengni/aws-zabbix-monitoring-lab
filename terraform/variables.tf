variable "aws_region" {
  description = "Region AWS utilisee pour le projet"
  type        = string
  default     = "eu-west-1"
}

variable "availability_zone" {
  description = "Zone de disponibilite AWS"
  type        = string
  default     = "eu-west-1b"
}

variable "vpc_cidr" {
  description = "Plage CIDR du VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Plage CIDR du subnet public"
  type        = string
  default     = "10.0.1.0/24"
}

variable "zabbix_instance_type" {
  description = "Type d'instance EC2 pour le serveur Zabbix"
  type        = string
  default     = "t3.small"
}

variable "linux_instance_type" {
  description = "Type d'instance EC2 pour le serveur Linux"
  type        = string
  default     = "t3.micro"
}

variable "windows_instance_type" {
  description = "Type d'instance EC2 pour le serveur Windows"
  type        = string
  default     = "t3.micro"
}