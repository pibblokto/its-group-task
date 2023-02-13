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
    type = string
}

variable "tag_mutability" {
    type = string
    default = "MUTABLE"
    validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.tag_mutability)
    error_message = "Valid values for var: tag_mutability are (MUTABLE, IMMUTABLE)."
  } 
}
