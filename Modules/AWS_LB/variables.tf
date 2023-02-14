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

variable "subnetId" {
  description = "Security_groups"
  type        = list(string)
  default     = []
}
variable "vpcId" {
  description = "VPC"
  type        = string

}

variable "target_type" {
  type        = string
  description = "Target type for load balancer target group"
  default     = "ip"
}


variable "internal" {
  type        = bool
  description = "Flag to indicate if load balancer is internal"
  default     = false
}

variable "load_balancer_type" {
  type        = string
  description = "Type of load balancer"
  default     = "application"
}
variable "http_port" {
  type        = string
  description = "Port"
  default     = 80
}
variable "securityGroups" {
  description = "Security groups used for ECS service"
  type = list(string)
  default = null
}

