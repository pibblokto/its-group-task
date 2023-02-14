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


#------------- RDS Option Group -------------#

variable "engine_name" {
  description = "Specifies the name of the engine that this option group should be associated with"
  type        = string
  default     = ""
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = ""
}




#------------- RDS Parameter Group -------------#
variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = ""
}




#------------- RDS Subnet Group -------------#
variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}




#------------- RDS Instance -------------#

variable "postgres_db" {
  type        = string
  description = "Postgres DB name"
  default     = ""
}

variable "database_username" {
  type        = string
  description = "Django secret key"
  default     = ""
}

variable "database_password" {
  type        = string
  description = "Database URL"
  default     = ""
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
  default     = ""
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = ""
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = ""
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  sensitive   = true
  default     = ""
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
  default     = ""
}

variable "instance_class" {
  description = "The RDS instance class"
  type        = string
  default     = ""
}

variable "storage_type" {
  description = "The RDS instance storage type"
  type        = string
  default     = ""
}

variable "allocated_storage" {
  description = "The amount of allocated storage"
  type        = number
  default     = null
}

variable "max_allocated_storage" {
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance"
  type        = number
  default     = null
}

variable "network_type" {
  description = "The network type of the DB instance"
  type        = string
  default     = ""
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "availability_zone" {
  description = "The availability zone of the instance"
  type        = string
  default     = ""
}

variable "ca_cert_identifier" {
  description = "Identifier of the CA certificate for the DB instance"
  type        = string
  default     = ""
}

variable "port" {
  description = "Database port"
  type        = number
  default     = null
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for. Must be between 0 and 35"
  type        = number
  default     = null
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots"
  type        = bool
  default     = true
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Set of log types to enable for exporting to CloudWatch logs"
  type        = list(string)
  default     = []
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to `true`"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted"
  type        = string
  default     = null
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: `09:46-10:16`. Must not overlap with `maintenance_window`"
  type        = string
  default     = ""
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: `ddd:hh24:mi-ddd:hh24:mi`. Eg: `Mon:00:00-Mon:03:00`"
  type        = string
  default     = ""
}

