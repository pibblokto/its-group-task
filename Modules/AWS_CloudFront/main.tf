resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = var.domain_name
    origin_id   = var.origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled         = var.enabled
  is_ipv6_enabled = var.is_ipv6_enabled
  comment         = var.comment

  #aliases = var.aliases

  default_cache_behavior {
    allowed_methods  = var.default_allowed_methods
    cached_methods   = var.default_cashed_methods
    target_origin_id = var.origin_id

    forwarded_values {
      query_string = var.default_query_strings

      cookies {
        forward = var.default_cookies_forward
      }
    }

    viewer_protocol_policy = var.default_viewer_protocol_policy
    min_ttl                = var.default_min_ttl
    default_ttl            = var.default_default_ttl
    max_ttl                = var.default_max_ttl
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      #locations        = var.locations
    }
  }

  tags = {
    Name = "${var.project}-${var.environment}-main-distribution"
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    #acm_certificate_arn            = var.acm_certificate_arn
  }
}