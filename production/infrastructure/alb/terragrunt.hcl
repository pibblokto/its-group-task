include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//AWS_LB"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
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

  # Application Load Balancer
  internal = false
  load_balancer_type = "application"
  subnets = dependency.vpc.outputs.public_subnets_ids
  security_groups = [dependency.alb_security_group.outputs.security_group_id]


  # Application Load Balancer Target Group
  target_group_port = 8000
  target_group_protocol = "HTTP"
  target_type = "ip"
  vpc_id = dependency.vpc.outputs.main_vpc_id
  deregistration_delay = 120

  health_check = {
    path                = "/"
    matcher             = "200"
    interval            = 15
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }


  # Application Load Balancer HTTPS Listener
  https_port = "443"
  ssl_policy = "ELBSecurityPolicy-2016-08"


  # Application Load Balancer Redirection Listener
  alb_redirection_port = "80"
  alb_redirection_port_protocol = "HTTP"

}

dependencies {

  paths = [
    "..//vpc",
    "..//alb_security_group",
    "..//app_security_group",
    "..//db_security_group"
  ]
}