// include "root" {
//   path = find_in_parent_folders()
//   expose         = true
//   merge_strategy = "deep"
// }


// terraform {
//   source = "${dirname(find_in_parent_folders())}//Modules//AWS_CloudFront"
// }

// include "envcommon" {
//   path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
// }

// include "alb" {
//   path           = "..//dependency_blocks/alb.hcl"
//   expose         = true
//   merge_strategy = "deep"
// }


// inputs = {

//   #------------- CloudFront Cache Policy -------------#

//   policy_comment = "My cache policy"
//   policy_min_ttl = 0
//   policy_default_ttl = 50
//   policy_max_ttl = 100

//   enable_accept_encoding_brotli = true
//   enable_accept_encoding_gzip   = true

//   header_items = [
//     "CloudFront-Viewer-City",
//     "CloudFront-Viewer-Country-Region-Name",
//     "CloudFront-Viewer-Country-Region",
//     "CloudFront-Viewer-Country-Name",
//     "CloudFront-Viewer-Country",
//     "Origin",
//     "Host",
//     "Accept",
//     "Referer",
//     "Accept-Datetime"
//   ]


//   #------------- CloudFront Distribution -------------#

//   domain_name                    = dependency.alb.outputs.alb_dns_name
//   http_port                      = 80
//   https_port                     = 443
//   origin_protocol_policy         = "http-only"
//   origin_ssl_protocols           = ["TLSv1.2"]
//   enabled                        = true
//   is_ipv6_enabled                = false
//   comment                        = "Module-generated distribution"
//   compress                       = true
//   default_viewer_protocol_policy = "redirect-to-https"
//   default_allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
//   default_cached_methods         = ["GET", "HEAD"]
//   distribution_min_ttl           = 0
//   distribution_default_ttl       = 3600
//   distribution_max_ttl           = 86400
//   aliases                        = ["app.guard-lite.com"]
//   price_class                    = "PriceClass_100"
//   restriction_type               = "none"
//   locations                      = []
//   cloudfront_default_certificate = false
//   minimum_protocol_version       = "TLSv1.2_2021"
//   ssl_support_method             = "sni-only"
//   http_version                   = "http2"

// }

// dependencies {

//   paths = [
//     "..//vpc",
//     "..//alb_security_group",
//     "..//alb",
//     "..//db_instance",
//     "..//ecs"
//   ]
// }