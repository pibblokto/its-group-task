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

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = ""
}
