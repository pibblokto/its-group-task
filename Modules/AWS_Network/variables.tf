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
  type        = string
  description = "VPC ip range"
  default     = ""
}

variable "private_subnets" {
  type        = list(string)
  description = "private subnets ranges"
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "public subnets ranges"
  default     = []
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Determine if to map public ip on lauch"
  default     = false
}
