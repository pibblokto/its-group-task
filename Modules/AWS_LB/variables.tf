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

variable "subnets" {
  description = "Security_groups"
  type        = list(string)
  default     = []
}
variable "vpc_id" {
  description = "VPC"
  type        = string
  default     = ""
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
variable "target_group_port" {
  type        = number
  description = "Port"
  default     = null
}
variable "security_groups" {
  description = "Security groups used for ECS service"
  type        = list(string)
  default     = []
}

variable "target_group_protocol" {
  type        = string
  description = "Target group protocol"
  default     = ""
}

variable "deregistration_delay" {
  type        = number
  description = "Target group deregistration delay"
  default     = null
}

variable "health_check" {
  type = object({
    path                = string
    matcher             = string
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
  })

  description = "Target group health check options"

  default = {
    path                = ""
    matcher             = ""
    interval            = null
    timeout             = null
    healthy_threshold   = null
    unhealthy_threshold = null
  }
}

variable "https_port" {
  type        = string
  description = "ALB HTTPS port"
  default     = ""
}

variable "ssl_policy" {
  type        = string
  description = "SSL policy name"
  default     = ""
}

variable "certificate_arn" {
  type        = string
  description = "SSL certificate ARN"
  sensitive   = true
  default     = ""
}

variable "alb_redirection_port" {
  type        = string
  description = "ALB redirection port"
  default     = ""
}

variable "alb_redirection_port_protocol" {
  type        = string
  description = "ALB redirection port protocol"
  default     = ""
}
