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


#---------- ALB Security Group ----------#
variable "ports_for_alb_sg" {
  description = "List of ingress ports for Application Load Balancer security group"
  type        = list(string)
  default     = []
}




#---------- App Security Group ----------#
variable "ports_for_application_sg" {
  description = "List of ingress ports for application security group"
  type        = list(string)
  default     = []
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
  default     = []
}

variable "app_security_group_id" {
  description = "Application security group ID"
  type        = list(string)
  default     = []
}
