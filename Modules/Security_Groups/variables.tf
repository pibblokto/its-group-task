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

variable "ports_for_alb_sg" {
  description = "List of ingress ports for Application Load Balancer security group"
  type        = list(string)
  default     = []
}

variable "ports_for_application_sg" {
  description = "List of ingress ports for application security group"
  type        = list(string)
  default     = []
}

variable "ports_for_database_sg" {
  description = "List of ingress ports for database security group"
  type        = list(string)
  default     = []
}
