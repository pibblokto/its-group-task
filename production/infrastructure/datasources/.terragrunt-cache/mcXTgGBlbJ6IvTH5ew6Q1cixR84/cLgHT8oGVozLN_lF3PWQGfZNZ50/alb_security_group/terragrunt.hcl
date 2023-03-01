include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//.?ref=v4.17.1"
}


include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
  expose = true
}

include "vpc" {
  path           = "..//dependency_blocks/vpc.hcl"
  expose         = true
  merge_strategy = "deep"
}


inputs = {

  vpc_id = dependency.vpc.outputs.vpc_id
  name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-alb-sg"
  use_name_prefix = true
  description = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-alb-sg"

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow all inbound traffic"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow all inbound traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  
  tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-alb-sg"
    Project = "${include.envcommon.locals.environment_vars.locals.project}"
    Environment = "${include.envcommon.locals.environment_vars.locals.environment}"
  }

}

dependencies {

  paths = [
    "..//vpc"
  ]
}