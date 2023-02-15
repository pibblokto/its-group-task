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

variable "tag_mutability" {
  description = "ECR tags mutability"
  type        = string
  default     = "IMMUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.tag_mutability)
    error_message = "Valid values for var: tag_mutability are (MUTABLE, IMMUTABLE)."
  }
}

variable "policy_json" {
  description = "Path to json file with lifecycle policy for ecr"
  type        = string
  default     = "./lifecycle_policy/policy.json"
}
