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

variable "ecr_name" {
  description = "ECR name"
  type        = string
  default     = ""
}

variable "tag_mutability" {
  description = "ECR tags mutability"
  type        = string
  default     = "IMMUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.tag_mutability)
    error_message = "Valid values for var: tag_mutability are (MUTABLE, IMMUTABLE)."
  }
}

