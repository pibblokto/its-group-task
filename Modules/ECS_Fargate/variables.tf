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

variable "aws_region" {
  description = "AWS Region to provision infrastructure"
  type        = string
  default     = ""
}

variable "account_id" {
  description = "AWS account ID to provision infrastructure"
  type        = string
  default     = ""
}

variable "s3_bucket_arn" {
  description = "S3 Bucket ARN"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "Subnets used for ECS service"
  type        = list(string)
  default     = []
}

variable "ecs_security_groups" {
  description = "Security groups used for ECS service"
  type        = list(string)
  default     = []
}

variable "alb_target_group_arn" {
  description = "Target group arn from alb for ECS service"
  type        = string
  default     = ""
}

variable "network_mode" {
  description = "The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host."
  type        = string
  default     = ""
}
variable "desired_count" {
  description = "Number of running tasks desired for your service"
  type        = number
  default     = null
}

variable "launch_type" {
  description = "AWS ECS Launch type - FARGATE OR EC2"
  type        = string
  default     = ""
}

variable "scheduling_strategy" {
  description = "The scheduling strategy to use for the service."
  type        = string
  default     = ""
}

variable "cpu" {
  description = "CPU for ECS service"
  type        = string
  default     = ""
}

variable "memory" {
  description = "Memory for ECS Service"
  type        = string
  default     = ""
}

variable "ecr_uri" {
  description = "ECR image URI"
  type        = string
  default     = ""
}

variable "init_container_name" {
  description = "Init container name"
  type        = string
  default     = ""
}

variable "init_container_command" {
  description = "Init container command"
  type        = list(string)
  default     = []
}

variable "main_container_name" {
  description = "Main container name"
  type        = string
  default     = ""
}

variable "main_container_port" {
  description = "Main container port"
  type        = number
  default     = null
}

variable "init_container_execution_condition" {
  description = "Init container execution condition"
  type        = string
  default     = ""
}

variable "max_capacity" {
  description = "Max task capacity for autoscaling"
  type        = number
  default     = null
}

variable "min_capacity" {
  description = "Min task capacity for autoscaling"
  type        = number
  default     = null
}

variable "appautoscaling_policy_type" {
  description = "Autoscaling policy type"
  type        = string
  default     = ""
}

variable "target_value" {
  description = "Autoscaling policy target value"
  type        = number
  default     = null
}

variable "predefined_metric_type" {
  description = "Autoscaling policy predefined metric type"
  type        = string
  default     = ""
}
