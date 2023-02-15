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

variable "acl" {
  description = "The canned ACL to apply"
  type        = string
  default     = "private"
}

variable "versioning_status" {
  description = "Defines whether to enable S3 bucket Versioning"
  type        = string
  default     = "Enabled"
}
