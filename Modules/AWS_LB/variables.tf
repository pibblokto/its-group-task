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




#--------- Application Load Balancer ---------#

variable "internal" {
  description = "Flag to indicate if load balancer is internal"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Type of load balancer"
  type        = string
  default     = "application"
}

variable "subnets" {
  description = "List of subnets for ALB"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "List of security groups used for ALB"
  type        = list(string)
  default     = []
}




#--------- Application Load Balancer Target Group ---------#

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = null
}

variable "target_type" {
  description = "Target type for load balancer target group"
  type        = string
  default     = "ip"
}

variable "target_group_port" {
  description = "Target Group port"
  type        = number
  default     = 8000
}

variable "target_group_protocol" {
  description = "Target group protocol"
  type        = string
  default     = "HTTP"
}

variable "deregistration_delay" {
  description = "Target group deregistration delay"
  type        = number
  default     = 120
}

variable "health_check" {
  description = "Target group health check options"
  type = object({
    path                = string
    matcher             = string
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
  })

  default = {
    path                = "/"
    matcher             = "200"
    interval            = 15
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}




#--------- Application Load Balancer HTTPS Listener ---------#

variable "https_port" {
  description = "ALB HTTPS port"
  type        = string
  default     = "443"
}

variable "ssl_policy" {
  description = "SSL policy name"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  description = "SSL certificate ARN"
  type        = string
  sensitive   = true
  default     = ""
}




#--------- Application Load Balancer Redirection Listener ---------#

variable "alb_redirection_port" {
  description = "ALB redirection port"
  type        = string
  default     = "80"
}

variable "alb_redirection_port_protocol" {
  description = "ALB redirection port protocol"
  type        = string
  default     = "HTTP"
}
