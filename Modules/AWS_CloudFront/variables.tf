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

variable "domain_name" {
  description = "Domain name for origin"
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content"
  type        = bool
  default     = true
}

variable "is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution"
  type        = bool
  default     = false
}

variable "comment" {
  description = "Any comment about distribution"
  type        = string
  default     = "Module-generated distribution"
}


variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution"
  type        = list(string)
  default     = [""]
}

variable "default_allowed_methods" {
  description = "List of allowed HTTP methods"
  type        = list(string)
  default     = [""]
}

variable "default_cashed_methods" {
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods"
  type        = list(string)
  default     = [""]
}

variable "origin_id" {
  description = "Unique identifier for the origin"
  type        = string
  default     = ""
}

variable "default_cookies_forward" {
  description = "Whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior"
  type        = string
  default     = "none"
}

variable "default_viewer_protocol_policy" {
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern"
  type        = string
  default     = "allow-all"
}

variable "default_min_ttl" {
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0"
  type        = number
  default     = 0
}


variable "default_default_ttl" {
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header."
  type        = number
}

variable "default_max_ttl" {
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0"
  type        = number
}

variable "price_class" {
  description = "the price class for this distribution"
  type        = string
  default     = "PriceClass_200"
  validation {
    condition     = contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], var.price_class)
    error_message = "Valid values for var: tag_mutability are (PriceClass_All, PriceClass_200, PriceClass_100)."
  }
}

variable "restriction_type" {
  description = "The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist"
  type        = string
  default     = "whitelist"
  validation {
    condition     = contains(["whitelist", "blacklist", "none"], var.restriction_type)
    error_message = "Valid values for var: tag_mutability are (none, whitelist, blacklist)."
  }
}

variable "locations" {
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)."
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "arn of certificate from aws certificate manager"
  type        = string
  default     = ""
}

variable "cloudfront_default_certificate" {
  description = ""
  type        = bool
  default     = true
}

variable "default_query_strings" {
  type    = bool
  default = false
}

variable "origin_protocol_policy" {
    description = "Specifies the minimum SSL/TLS protocol that CloudFront uses when connecting to your origin over HTTPS"
    type = string
    default = "http-only"
    validation {
    condition     = contains(["http-only", "match-viewer", "https-only"], var.origin_protocol_policy)
    error_message = "Valid values for var: tag_mutability are (http-only, match-viewer, https-only)."
  }
}

variable "origin_ssl_protocols" {
    description = ""
    type = string
    default = ["TLSv1.2"]
}
    