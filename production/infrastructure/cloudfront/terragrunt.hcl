include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//CloudFront"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
}

include "alb" {
  path           = "..//dependency_blocks/alb.hcl"
  expose         = true
  merge_strategy = "deep"
}


inputs = {
  domain_name     = ""
  enabled         = true
  is_ipv6_enabled = false
  comment         = "Module-generated distribution"
  #aliases                        = [""]
  default_allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  default_cashed_methods         = ["GET", "HEAD"]
  origin_id                      = ""
  default_cookies_forward        = "none"
  default_viewer_protocol_policy = "redirect-to-https"
  default_min_ttl                = 0
  default_default_ttl            = 0
  default_max_ttl                = 0
  price_class                    = "PriceClass_200"
  restriction_type               = "none"
  locations                      = [""]
  #acm_certificate_arn            = ""
  cloudfront_default_certificate = true
  default_query_strings          = false
  origin_protocol_policy = "http-only"
  origin_ssl_protocols   = ["TLSv1.2"]
}

dependencies {

  paths = [
    "..//alb"
  ]
}