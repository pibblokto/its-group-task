#------------- CloudFront ALB Cache Policy -------------#

resource "aws_cloudfront_cache_policy" "alb" {
  name        = "${var.project}-${var.environment}-alb-cache-policy"
  comment     = var.alb_policy_comment
  default_ttl = var.alb_policy_default_ttl
  max_ttl     = var.alb_policy_max_ttl
  min_ttl     = var.alb_policy_min_ttl
  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = var.alb_enable_accept_encoding_brotli
    enable_accept_encoding_gzip   = var.alb_enable_accept_encoding_gzip
    cookies_config {
      cookie_behavior = "all"
    }
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = var.alb_header_items
      }
    }
    query_strings_config {
      query_string_behavior = "all"
    }
  }
}

#------------- CloudFront S3 Origin Access Control -------------#

resource "aws_cloudfront_origin_access_control" "s3_access_control" {
  name                              = "${var.project}-${var.environment}-access-control"
  description                       = "${var.project}-${var.environment}-access-control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

#------------- CloudFront S3 Caching Optimized Policy -------------#

resource "aws_cloudfront_cache_policy" "s3" {
  name        = "${var.project}-${var.environment}-s3-cache-policy"
  comment     = var.s3_policy_comment
  default_ttl = var.s3_policy_default_ttl
  max_ttl     = var.s3_policy_max_ttl
  min_ttl     = var.s3_policy_min_ttl
  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = var.s3_enable_accept_encoding_brotli
    enable_accept_encoding_gzip   = var.s3_enable_accept_encoding_gzip
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

#------------- CloudFront Distribution -------------#

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {

    domain_name = var.alb_domain_name
    origin_id   = "${var.project}-${var.environment}-alb-origin"

    custom_origin_config {
      http_port              = var.alb_http_port
      https_port             = var.alb_https_port
      origin_protocol_policy = var.alb_origin_protocol_policy
      origin_ssl_protocols   = var.alb_origin_ssl_protocols
    }
  }

  origin {
    domain_name              = var.s3_domain_name
    origin_id                = "${var.project}-${var.environment}-s3-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_access_control.id
  }

  enabled = var.enabled
  comment = var.comment

  aliases = var.aliases

  default_cache_behavior {
    compress               = var.compress
    allowed_methods        = var.default_allowed_methods
    cached_methods         = var.default_cached_methods
    target_origin_id       = "${var.project}-${var.environment}-s3-origin"
    viewer_protocol_policy = var.default_viewer_protocol_policy
    cache_policy_id        = aws_cloudfront_cache_policy.s3.id
  }

  ordered_cache_behavior {
    path_pattern           = var.path_pattern
    compress               = var.ordered_compress
    allowed_methods        = var.ordered_allowed_methods
    cached_methods         = var.ordered_cached_methods
    target_origin_id       = "${var.project}-${var.environment}-alb-origin"
    viewer_protocol_policy = var.ordered_viewer_protocol_policy
    cache_policy_id        = aws_cloudfront_cache_policy.alb.id
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
    aws_cloudfront_cache_policy.alb,
    aws_cloudfront_origin_access_control.s3_access_control,
    aws_cloudfront_cache_policy.s3
  ]

  tags = {
    Name        = "${var.project}-${var.environment}-distribution"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

#------------- Update S3 Bucket Policy -------------#

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = var.s3_bucket_id
  policy = data.aws_iam_policy_document.allow_access_from_cloudfront.json
}

data "aws_iam_policy_document" "allow_access_from_cloudfront" {
  version = "2008-10-17"
  statement {

    sid = "AllowCloudFrontServicePrincipal"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${var.s3_bucket_arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["arn:aws:cloudfront::${var.account_id}:distribution/${aws_cloudfront_distribution.cloudfront_distribution.id}"]

    }
  }
}
