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
  description = "VPC CIDR Block to use"
  type        = string
  default     = null
}

variable "private_subnets" {
  description = "Private subnets CIDR Blocks"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "Public subnets CIDR Blocks"
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "Determine whether to map public ip on lauch in Public Subnets"
  type        = bool
  default     = true
}
