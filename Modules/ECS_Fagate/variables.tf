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

variable "replicaCount" {
    type = number
    description = "The number of replicas"
}

variable "memory" {
    type = number
    description = "The amount of memory for pod"
}

variable "cpu" {
    type = number
    description = "The amount of CPU"
}

variable "subnetId" {
    type = string
    description = "Subnet"
}

variable "vpcId" {
    type = string
    description = "VPC"
} 
}