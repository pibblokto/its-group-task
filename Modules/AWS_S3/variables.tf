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

variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
  default     = ""
}

variable "acl" {
  type    = string
  default = ""
}

variable "versioning_status" {
  type    = string
  default = ""
}
