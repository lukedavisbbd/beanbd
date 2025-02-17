variable "db_username" {
  type        = string
  description = "The username for the database"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "The password for the database"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "The name of the database"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR block for VPC"
}

variable "region" {
  type        = string
  description = "The region where the resources will be deployed."
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
}
