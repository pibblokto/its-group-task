variable "vpc_id" {
  description = "VPC ID to use"
  type        = string
  default     = ""
}

variable "project" {
  description = "Project name"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = ""
}


variable "ports_for_database_sg" {
  description = "List of ingress ports for database security group"
  type        = list(string)
  default     = []
}

variable "app_security_group_id" {
  description = "Application security group ID"
  type        = string
  default     = ""
}
