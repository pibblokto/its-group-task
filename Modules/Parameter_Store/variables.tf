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

variable "tier" {
  description = "Parameter tier to assign to the parameter. If not specified, will use the default parameter tier for the region. Valid tiers are `Standard`, `Advanced`, and `Intelligent-Tiering`. Downgrading an `Advanced` tier parameter to `Standard` will recreate the resource"
  type        = string
  default     = "Standard"
}

variable "type" {
  description = "Type of the parameter. Valid types are `String`, `StringList` and `SecureString`"
  type        = string
  default     = "SecureString"
}

variable "db_username" {
  description = "RDS instance username"
  type        = string
  sensitive   = true
  default     = null
}

variable "db_password" {
  description = "RDS instance password"
  type        = string
  sensitive   = true
  default     = null
}

variable "db_endpoint" {
  description = "RDS instance endpoint"
  type        = string
  sensitive   = true
  default     = null
}

variable "db_name" {
  description = "RDS instance DB name"
  type        = string
  sensitive   = true
  default     = null
}
