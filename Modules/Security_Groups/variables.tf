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




#---------- Security Group ----------#

variable "vpc_id" {
  description = "VPC ID to use"
  type        = string
  default     = null
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
  default     = null
}

variable "security_group_description" {
  description = "Security group description"
  type        = string
  default     = null
}





#---------- Ingress rule with CIDR Blocks ----------#

variable "ingress_with_cidr_rule_from_ports" {
  description = "List of `from_port` for ingress rule"
  type        = list(string)
  default     = []
}

variable "ingress_with_cidr_rule_to_ports" {
  description = "List of `to_port` for ingress rule"
  type        = list(string)
  default     = []
}

variable "ingress_with_cidr_rule_protocols" {
  description = "List of `protocol` for ingress rule"
  type        = list(string)
  default     = []
}

variable "ingress_with_cidr_rule_cidr_blocks" {
  description = "List of `cidr_blcoks` for ingress rule"
  type        = list(string)
  default     = []
}

variable "ingress_with_cidr_rule_description" {
  description = "List of `description` for ingress rule"
  type        = list(string)
  default     = []
}





#---------- Ingress rule with source security group ----------#

variable "ingress_with_source_sg_rule_from_ports" {
  description = "List of `from_port` for ingress rule"
  type        = list(string)
  default     = []
}

variable "ingress_with_source_sg_rule_to_ports" {
  description = "List of `to_port` for ingress rule"
  type        = list(string)
  default     = []
}

variable "ingress_with_source_sg_rule_protocols" {
  description = "List of `protocol` for ingress rule"
  type        = list(string)
  default     = []
}

variable "ingress_with_source_sg_rule_security_groups" {
  description = "List of `source_security_group_id` for ingress rule"
  type        = list(string)
  default     = []
}

variable "ingress_with_source_sg_rule_description" {
  description = "List of `description` for ingress rule"
  type        = list(string)
  default     = []
}





#---------- Egress rule with CIDR Blocks ----------#

variable "egress_with_cidr_rule_from_ports" {
  description = "List of `from_port` for egress rule"
  type        = list(string)
  default     = []
}

variable "egress_with_cidr_rule_to_ports" {
  description = "List of `to_port` for egress rule"
  type        = list(string)
  default     = []
}

variable "egress_with_cidr_rule_protocols" {
  description = "List of `protocol` for egress rule"
  type        = list(string)
  default     = []
}

variable "egress_with_cidr_rule_cidr_blocks" {
  description = "List of `cidr_blcoks` for egress rule"
  type        = list(string)
  default     = []
}

variable "egress_with_cidr_rule_description" {
  description = "List of `description` for egress rule"
  type        = list(string)
  default     = []
}





#---------- Egress rule with source security group ----------#

variable "egress_with_source_sg_rule_from_ports" {
  description = "List of `from_port` for egress rule"
  type        = list(string)
  default     = []
}

variable "egress_with_source_sg_rule_to_ports" {
  description = "List of `to_port` for egress rule"
  type        = list(string)
  default     = []
}

variable "egress_with_source_sg_rule_protocols" {
  description = "List of `protocol` for egress rule"
  type        = list(string)
  default     = []
}

variable "egress_with_source_sg_rule_security_groups" {
  description = "List of `source_security_group_id` for egress rule"
  type        = list(string)
  default     = []
}

variable "egress_with_source_sg_rule_description" {
  description = "List of `description` for egress rule"
  type        = list(string)
  default     = []
}
