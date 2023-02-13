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
  type        =  string
  description = "VPC ip range"
}

variable "private_subnets" {
  type        =  list(string)
  description = "private subnets ranges"
}

variable "public_subnets" {
  type        =  list(string)
  description = "public subnets ranges"
}