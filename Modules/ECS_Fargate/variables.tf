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

variable "aws_region" {
  description = "AWS Region to provision infrastructure"
  type        = string
  default     = null
}

variable "account_id" {
  description = "AWS account ID to provision infrastructure"
  type        = string
  default     = null
}




#---------- S3 Bucket ----------#

variable "s3_bucket_arn" {
  description = "S3 Bucket ARN"
  type        = string
  default     = null
}




#---------- Task Definition ----------#

variable "launch_type" {
  description = "AWS ECS Launch type - FARGATE OR EC2"
  type        = string
  default     = "FARGATE"
}

variable "network_mode" {
  description = "The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host."
  type        = string
  default     = "awsvpc"
}

variable "cpu" {
  description = "CPU for Task Definition"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memory for Task Definition"
  type        = string
  default     = "512"
}

variable "ecr_uri" {
  description = "ECR image URI"
  type        = string
  default     = null
}

variable "main_container_name" {
  description = "Main container name"
  type        = string
  default     = "django-app"
}

variable "main_container_port" {
  description = "Main container port"
  type        = number
  default     = 8000
}




#---------- ECS Service ----------#

variable "scheduling_strategy" {
  description = "The scheduling strategy to use for the service."
  type        = string
  default     = "REPLICA"
}

variable "desired_count" {
  description = "Number of running tasks desired for your service"
  type        = number
  default     = 2
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
  default     = null
}




#---------- ECS Service Autoscaling ----------#

variable "max_capacity" {
  description = "Max task capacity for autoscaling"
  type        = number
  default     = 3
}

variable "min_capacity" {
  description = "Min task capacity for autoscaling"
  type        = number
  default     = 2
}

variable "appautoscaling_policy_type" {
  description = "Autoscaling policy type"
  type        = string
  default     = "TargetTrackingScaling"
}

variable "target_value" {
  description = "Autoscaling policy target value"
  type        = number
  default     = 70
}

variable "predefined_metric_type" {
  description = "Autoscaling policy predefined metric type"
  type        = string
  default     = "ECSServiceAverageCPUUtilization"
}
