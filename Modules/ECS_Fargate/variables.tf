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
  description = "Subnets used for ECS service"
  type = list(string)
  default = null
}
variable "ecs_security_groups" {
  description = "Security groups used for ECS service"
  type = list(string)
  default = null
}

variable "alb_target_group_arn" {
  description = "Target group arn from alb for ECS service"
  type = string
  default = null
}


variable "container_port" {
  description = "Port to run your task on for ECS service"
  type = number
  default = null
}

variable "container_name" {
  description = "Name of your task on for ECS service"
  type = string
  default = null
}

variable "network_mode" {
  description = "The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host."
  type = string
  default = null
}
variable "desired_count" {
  description = "Number of running tasks desired for your service"
  type = number
  default = 1
}

variable "launch_type" {
  description = "AWS ECS Launch type - FARGATE OR EC2"
  type = string
  default = null
}

variable "scheduling_strategy" {
  description = "The scheduling strategy to use for the service."
  type = string
  default = null
}

variable "cpu" {
  description = "CPU for ECS service"
  type = string
  default = null
}

variable "memory" {
  description = "Memory for ECS Service"
  type = string
  default = null
}