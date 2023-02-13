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

variable "sns_topic" {
  description = "The SNS topic to send events to"
  type        = string
  default     = ""
}

variable "source_type" {
  description = "The type of source that will be generating the events"
  type        = string
  default     = ""
}

variable "source_ids" {
  description = "A list of identifiers of the event sources for which events will be returned"
  type        = list(string)
  default     = []
}

variable "enabled" {
  description = "A boolean flag to enable/disable the subscription"
  type        = bool
  default     = true
}

variable "event_categories" {
  description = "A list of event categories for a SourceType that you want to subscribe to"
  type        = list(string)
  default     = []
}
