#------------- CloudFront Cache Policy -------------#
resource "aws_cloudfront_cache_policy" "example" {
  name        = "${var.project}-${var.environment}-cache-policy"
  comment     = var.policy_comment
  default_ttl = var.policy_default_ttl
  max_ttl     = var.policy_max_ttl
  min_ttl     = var.policy_min_ttl
  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = var.enable_accept_encoding_brotli
    enable_accept_encoding_gzip   = var.enable_accept_encoding_gzip
    cookies_config {
      cookie_behavior = "all"
    }
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = var.header_items
      }
    }
    query_strings_config {
      query_string_behavior = "all"
    }
  }
}




#------------- CloudFront Distribution -------------#
resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = var.domain_name
    origin_id   = "${var.project}-${var.environment}-alb-origin"

    custom_origin_config {
      http_port              = var.http_port
      https_port             = var.https_port
      origin_protocol_policy = var.origin_protocol_policy
      origin_ssl_protocols   = var.origin_ssl_protocols
    }
  }

  enabled = var.enabled
  comment = var.comment

  aliases = var.aliases

  default_cache_behavior {
    compress               = var.compress
    allowed_methods        = var.default_allowed_methods
    cached_methods         = var.default_cached_methods
    target_origin_id       = "${var.project}-${var.environment}-alb-origin"
    viewer_protocol_policy = var.default_viewer_protocol_policy
    cache_policy_id        = aws_cloudfront_cache_policy.example.id

    default_ttl = var.distribution_default_ttl
    min_ttl     = var.distribution_min_ttl
    max_ttl     = var.distribution_max_ttl

  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.locations
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    acm_certificate_arn            = var.certificate_arn
    minimum_protocol_version       = var.minimum_protocol_version
    ssl_support_method             = var.ssl_support_method
  }

  http_version    = var.http_version
  is_ipv6_enabled = var.is_ipv6_enabled

  depends_on = [
    aws_cloudfront_cache_policy.example
  ]

  tags = {
    Name        = "${var.project}-${var.environment}-distribution"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}
