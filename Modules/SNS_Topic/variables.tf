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

variable "display_name" {
  description = "The display name for the topic"
  type        = string
  default     = "RDS-Events"
}

variable "fifo_topic" {
  description = "Boolean indicating whether or not to create a FIFO (first-in-first-out) topic"
  type        = bool
  default     = false
}

variable "sns_topic_subscription_protocol" {
  description = "Protocol to use. Valid values are: `sqs`, `sms`, `lambda`, `firehose`, and `application`. Protocols `email`, `email-json`, `http` and `https` are also valid but partially supported"
  type        = string
  default     = ""
}

variable "sns_topic_subscribers" {
  description = "List of SNS Topic subscribers"
  type        = list(string)
  default     = []
}
