include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-alb//.?ref=v8.3.1"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  config_vars      = read_terragrunt_config(find_in_parent_folders("config.hcl"))

  # Extract out common variables for reuse
  project         = local.environment_vars.locals.project
  environment     = local.environment_vars.locals.environment
  certificate_arn = local.config_vars.locals.certificate_arn
}

include "vpc" {
  path           = "..//dependency_blocks/vpc.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "alb_security_group" {
  path           = "..//dependency_blocks/alb_security_group.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {

  enable_http2                     = true
  enable_cross_zone_load_balancing = true
  idle_timeout                     = 60
  ip_address_type                  = "ipv4"
  internal                         = false
  vpc_id                           = "${dependency.vpc.outputs.vpc_id}"
  create_security_group            = false

  name               = "${local.project}-${local.environment}-alb"
  load_balancer_type = "application"
  subnets            = "${dependency.vpc.outputs.public_subnets}"
  security_groups    = ["${dependency.alb_security_group.outputs.security_group_id}"]

  target_groups = [
    {
      name                 = "${local.project}-${local.environment}-tg"
      backend_protocol     = "HTTP"
      backend_port         = 8000
      target_type          = "ip"
      deregistration_delay = 120
      ip_address_type      = "ipv4"

      health_check = {
        enabled             = true
        path                = "/"
        protocol            = "HTTP"
        port                = "traffic-port"
        matcher             = "200"
        interval            = 15
        timeout             = 10
        healthy_threshold   = 2
        unhealthy_threshold = 2
      }
      
      protocol_version = "HTTP1"

      tags = {
        Name = "${local.project}-${local.environment}-tg"
      }

    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "${local.certificate_arn}"
      ssl_policy         = "ELBSecurityPolicy-2016-08"
      action_type        = "forward"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      action_type        = "forward"
      target_group_index = 0
    }
  ]

  lb_tags = {
    Name = "${local.project}-${local.environment}-alb"
  }

  tags = {
    Project     = "${local.project}"
    Environment = "${local.environment}"    
  }

}

dependencies {

  paths = [
    "..//datasources",
    "..//vpc",
    "..//alb_security_group",
    "..//app_security_group",
    "..//db_security_group"
  ]
}
