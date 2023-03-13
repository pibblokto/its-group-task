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

variable "account_id" {
  description = "AWS account ID to provision infrastructure"
  type        = string
  default     = null
}

#------------- CloudFront ALB Cache Policy -------------#

variable "alb_policy_comment" {
  description = "Any comment about cache policy"
  type        = string
  default     = "Module-generated policy"
}

variable "alb_policy_min_ttl" {
  description = "The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated"
  type        = number
  default     = 1
}

variable "alb_policy_default_ttl" {
  description = "The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated"
  type        = number
  default     = 86400
}

variable "alb_policy_max_ttl" {
  description = "The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated"
  type        = number
  default     = 31536000
}

variable "alb_header_items" {
  description = "Choose headers to cache. MAXIMUM IS 10"
  type        = list(string)
  default = [
    "CloudFront-Viewer-City",
    "CloudFront-Viewer-Country-Region-Name",
    "CloudFront-Viewer-Country-Region",
    "CloudFront-Viewer-Country-Name",
    "CloudFront-Viewer-Country",
    "CloudFront-Viewer-Http-Version",
    "CloudFront-Forwarded-Proto",
    "CloudFront-Is-Android-Viewer",
    "CloudFront-Is-IOS-Viewer",
    "CloudFront-Is-Desktop-Viewer",
    "CloudFront-Is-SmartTV-Viewer",
    "CloudFront-Is-Tablet-Viewer",
    "CloudFront-Is-Mobile-Viewer",
    "Origin",
    "Host",
    "Accept",
    "Authorization",
    "Accept-Encoding",
    "Accept-Language",
    "Accept-Charset",
    "Referer",
    "CloudFront-Viewer-Postal-Code",
    "CloudFront-Viewer-Time-Zone",
    "CloudFront-Viewer-Latitude",
    "CloudFront-Viewer-Longitude",
    "CloudFront-Viewer-Metro-Code",
    "Access-Control-Request-Method",
    "Access-Control-Request-Headers",
    "Accept-Datetime"
  ]
}

variable "alb_enable_accept_encoding_brotli" {
  description = "A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin"
  type        = bool
  default     = true
}

variable "alb_enable_accept_encoding_gzip" {
  description = "A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin"
  type        = bool
  default     = true
}


#------------- CloudFront S3 Cache Policy -------------#

variable "s3_policy_comment" {
  description = "Any comment about cache policy"
  type        = string
  default     = "Module-generated policy"
}

variable "s3_policy_min_ttl" {
  description = "The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated"
  type        = number
  default     = 1
}

variable "s3_policy_default_ttl" {
  description = "The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated"
  type        = number
  default     = 86400
}

variable "s3_policy_max_ttl" {
  description = "The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated"
  type        = number
  default     = 31536000
}

variable "s3_enable_accept_encoding_brotli" {
  description = "A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin"
  type        = bool
  default     = true
}

variable "s3_enable_accept_encoding_gzip" {
  description = "A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin"
  type        = bool
  default     = true
}

#------------- CloudFront Distribution -------------#

# ALB Origin

variable "alb_domain_name" {
  description = "Domain name for origin"
  type        = string
  default     = null
}

variable "alb_http_port" {
  description = "Origin HTTP port"
  type        = number
  default     = 80
}

variable "alb_https_port" {
  description = "Origin HTTPS port"
  type        = number
  default     = 443
}

variable "alb_origin_protocol_policy" {
  description = "Specifies the minimum SSL/TLS protocol that CloudFront uses when connecting to your origin over HTTPS"
  type        = string
  default     = "http-only"
  validation {
    condition     = contains(["http-only", "match-viewer", "https-only"], var.alb_origin_protocol_policy)
    error_message = "Valid values for var: origin_protocol_policy are (http-only, match-viewer, https-only)."
  }
}

variable "alb_origin_ssl_protocols" {
  description = "Minimum origin SSL protocol"
  type        = list(string)
  default     = ["TLSv1.2"]
}


# S3 Origin

variable "s3_domain_name" {
  description = "Domain name for origin"
  type        = string
  default     = null
}

variable "s3_bucket_id" {
  description = "S3 Bucket ID"
  type        = string
  default     = null
}

variable "s3_bucket_arn" {
  description = "S3 Bucket ARN"
  type        = string
  default     = null
}

# Default Cache Behaviour

variable "compress" {
  description = "Whether you want CloudFront to automatically compress content for web requests"
  type        = bool
  default     = true
}

variable "default_viewer_protocol_policy" {
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern"
  type        = string
  default     = "redirect-to-https"
}

variable "default_allowed_methods" {
  description = "List of allowed HTTP methods"
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "default_cached_methods" {
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "distribution_min_ttl" {
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated"
  type        = number
  default     = 0
}

variable "distribution_default_ttl" {
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an `Cache-Control max-age` or `Expires` header"
  type        = number
  default     = 3600
}

variable "distribution_max_ttl" {
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of `Cache-Control max-age`, `Cache-Control s-maxage`, and `Expires` headers"
  type        = number
  default     = 86400
}

# Ordered Cache Behaviour

variable "path_pattern" {
  description = "Pattern that specifies which requests you want this cache behavior to apply to"
  type        = string
  default     = "*"
}

variable "ordered_compress" {
  description = "Whether you want CloudFront to automatically compress content for web requests"
  type        = bool
  default     = true
}

variable "ordered_viewer_protocol_policy" {
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern"
  type        = string
  default     = "allow-all"
}

variable "ordered_allowed_methods" {
  description = "List of allowed HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "ordered_cached_methods" {
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "ordered_min_ttl" {
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated"
  type        = number
  default     = 0
}

variable "ordered_default_ttl" {
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an `Cache-Control max-age` or `Expires` header"
  type        = number
  default     = 86400
}

variable "ordered_max_ttl" {
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of `Cache-Control max-age`, `Cache-Control s-maxage`, and `Expires` headers"
  type        = number
  default     = 31536000
}

# The rest of the CloudFront Distribution variables

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
  description = "Comma separated list. Extra CNAMEs (alternate domain names), if any, for this distribution"
  type        = list(string)
  default     = []
}

variable "price_class" {
  description = "the price class for this distribution"
  type        = string
  default     = "PriceClass_100"
  validation {
    condition     = contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], var.price_class)
    error_message = "Valid values for var: price_class are (PriceClass_All, PriceClass_200, PriceClass_100)."
  }
}

variable "restriction_type" {
  description = "The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist"
  type        = string
  default     = "none"
  validation {
    condition     = contains(["whitelist", "blacklist", "none"], var.restriction_type)
    error_message = "Valid values for var: restriction_type are (none, whitelist, blacklist)."
  }
}

variable "locations" {
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)."
  type        = list(string)
  default     = []
}

variable "cloudfront_default_certificate" {
  description = "Set to `true`, if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "SSL certificate ARN"
  type        = string
  sensitive   = true
  default     = null
}

variable "minimum_protocol_version" {
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections"
  type        = string
  default     = "TLSv1.2_2021"
}

variable "ssl_support_method" {
  description = "Specifies how you want CloudFront to serve HTTPS requests"
  type        = string
  default     = "sni-only"
}

variable "http_version" {
  description = "The maximum HTTP version to support on the distribution"
  type        = string
  default     = "http2"
}

