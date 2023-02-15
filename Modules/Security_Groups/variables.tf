variable "vpc_id" {
  description = "VPC ID to use"
  type        = string
  default     = null
}

variable "project" {
  description = "Project name"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = null
}




#---------- ALB Security Group ----------#
variable "ports_for_alb_sg" {
  description = "List of ingress ports for Application Load Balancer security group"
  type        = list(string)
  default     = ["80", "443"]
}




#---------- App Security Group ----------#
variable "ports_for_application_sg" {
  description = "List of ingress ports for application security group"
  type        = list(string)
  default     = ["8000"]
}

variable "alb_security_group_id" {
  description = "ALB security group ID"
  type        = list(string)
  default     = []
}




#---------- DB Security Group ----------#
variable "ports_for_database_sg" {
  description = "List of ingress ports for database security group"
  type        = list(string)
  default     = ["5432"]
}

variable "app_security_group_id" {
  description = "Application security group ID"
  type        = list(string)
  default     = []
}
