include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//CloudFront"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  config_vars      = read_terragrunt_config(find_in_parent_folders("config.hcl"))

  # Extract out common variables for reuse
  project         = local.environment_vars.locals.project
  environment     = local.environment_vars.locals.environment
  certificate_arn = local.config_vars.locals.certificate_arn
  account_id      = local.config_vars.locals.account_id
}

include "s3" {
  path           = "..//dependency_blocks/s3.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "alb" {
  path           = "..//dependency_blocks/alb.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {

  project         = "${local.project}"
  environment     = "${local.environment}"
  certificate_arn = "${local.certificate_arn}"
  account_id      = "${local.account_id}"   

  #------------- CloudFront ALB Cache Policy -------------# 

  alb_policy_comment     = "${local.project}-${local.environment}-alb-cache-policy"
  alb_policy_min_ttl     = 1
  alb_policy_default_ttl = 3600
  alb_policy_max_ttl     = 86400

  alb_enable_accept_encoding_brotli = true
  alb_enable_accept_encoding_gzip   = true

  alb_header_items = [
    "CloudFront-Viewer-City",
    "CloudFront-Viewer-Country-Region-Name",
    "CloudFront-Viewer-Country-Region",
    "CloudFront-Viewer-Country-Name",
    "CloudFront-Viewer-Country",
    "Origin",
    "Host",
    "Accept",
    "Referer",
    "Accept-Datetime"
  ]


#------------- CloudFront S3 Cache Policy -------------# 
  s3_policy_comment     = "${local.project}-${local.environment}-s3-cache-policy"
  s3_policy_min_ttl     = 1
  s3_policy_default_ttl = 86400
  s3_policy_max_ttl     = 31536000

  s3_enable_accept_encoding_brotli = true
  s3_enable_accept_encoding_gzip   = true

  #------------- CloudFront Distribution -------------#

  # ALB Origin
  alb_domain_name                    = "${dependency.alb.outputs.lb_dns_name}"
  alb_http_port                      = 80
  alb_https_port                     = 443
  alb_origin_protocol_policy         = "http-only"
  alb_origin_ssl_protocols           = ["TLSv1.2"]

  # S3 Origin
  s3_domain_name = "${dependency.s3.outputs.s3_bucket_bucket_domain_name}"
  s3_bucket_id   = "${dependency.s3.outputs.s3_bucket_id}"
  s3_bucket_arn  = "${dependency.s3.outputs.s3_bucket_arn}"

  enabled          = true
  is_ipv6_enabled  = true
  comment          = "${local.project}-${local.environment}-distribution"

  # Default Cache Behaviour
  compress                       = true
  default_viewer_protocol_policy = "allow-all"
  default_allowed_methods        = ["GET", "HEAD", "OPTIONS"]
  default_cached_methods         = ["GET", "HEAD", "OPTIONS"]

  # Ordered Cache Behaviour
  path_pattern                   = "*"
  ordered_compress               = true
  ordered_allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  ordered_cached_methods         = ["GET", "HEAD"]
  ordered_viewer_protocol_policy = "redirect-to-https"

  aliases                        = ["app.guard-lite.com"]
  price_class                    = "PriceClass_100"
  restriction_type               = "none"
  locations                      = []
  cloudfront_default_certificate = false
  minimum_protocol_version       = "TLSv1.2_2021"
  ssl_support_method             = "sni-only"
  http_version                   = "http2and3"

}

dependencies {

  paths = [
    "..//ecr",
    "..//s3",
    "..//datasources",
    "..//vpc",
    "..//alb_security_group",
    "..//alb",
    "..//db_instance",
    "..//parameter_store"
  ]
}
