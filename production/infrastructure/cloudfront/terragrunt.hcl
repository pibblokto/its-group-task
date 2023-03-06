include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//AWS_CloudFront"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  config_vars      = read_terragrunt_config(find_in_parent_folders("config.hcl"))

  # Extract out common variables for reuse
  project         = local.environment_vars.locals.project
  environment     = local.environment_vars.locals.environment
  aws_region      = local.region_vars.locals.aws_region
  certificate_arn = local.config_vars.locals.certificate_arn
}

include "alb" {
  path           = "..//dependency_blocks/alb.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {

  project         = "${local.project}"
  environment     = "${local.environment}"
  aws_region      = "${local.aws_region}"
  certificate_arn = "${local.certificate_arn}"

  #------------- CloudFront Cache Policy -------------# 

  policy_comment     = "${local.project}-${local.environment}-cache-policy"
  policy_min_ttl     = 1
  policy_default_ttl = 50
  policy_max_ttl     = 100

  enable_accept_encoding_brotli = true
  enable_accept_encoding_gzip   = true

  header_items = [
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

  #------------- CloudFront Distribution -------------#

  domain_name                    = "${dependency.alb.outputs.lb_dns_name}"
  http_port                      = 80
  https_port                     = 443
  origin_protocol_policy         = "http-only"
  origin_ssl_protocols           = ["TLSv1.2"]
  enabled                        = true
  is_ipv6_enabled                = true
  comment                        = "${local.project}-${local.environment}-distribution"
  compress                       = true
  default_viewer_protocol_policy = "redirect-to-https"
  default_allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  default_cached_methods         = ["GET", "HEAD"]
  distribution_min_ttl           = 0
  distribution_default_ttl       = 3600
  distribution_max_ttl           = 86400
  aliases                        = ["app.guard-lite.com"]
  price_class                    = "PriceClass_100"
  restriction_type               = "none"
  locations                      = []
  cloudfront_default_certificate = false
  minimum_protocol_version       = "TLSv1.2_2021"
  ssl_support_method             = "sni-only"
  http_version                   = "http2"

}

dependencies {

  paths = [
    "..//datasources",
    "..//vpc",
    "..//alb_security_group",
    "..//alb",
    "..//db_instance",
    "..//parameter_store",
    "..//ecs"
  ]
}
