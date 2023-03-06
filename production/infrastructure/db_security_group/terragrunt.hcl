include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//.?ref=v4.17.1"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  project     = local.environment_vars.locals.project
  environment = local.environment_vars.locals.environment
}

include "vpc" {
  path           = "..//dependency_blocks/vpc.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "app_security_group" {
  path           = "..//dependency_blocks/app_security_group.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {

  vpc_id = "${dependency.vpc.outputs.vpc_id}"

  name            = "${local.project}-${local.environment}-db-sg"
  use_name_prefix = true
  description     = "${local.project}-${local.environment}-db-sg"

  ingress_with_source_security_group_id = [
    {
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      description              = "Allow all inbound traffic from App SG"
      source_security_group_id = "${dependency.app_security_group.outputs.security_group_id}"
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
    Name        = "${local.project}-${local.environment}-db-sg"
    Project     = "${local.project}"
    Environment = "${local.environment}"
  }

}

dependencies {

  paths = [
    "..//datasources",
    "..//vpc",
    "..//alb_security_group",
    "..//app_security_group"
  ]
}
