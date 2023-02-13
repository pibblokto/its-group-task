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

variable "vpc_cidr" {
  description = "VPC ip range"
}

variable "private_subnets" {
  description = "private subnets ranges"
}

variable "public_subnets" {
  description = "public subnets ranges"
}