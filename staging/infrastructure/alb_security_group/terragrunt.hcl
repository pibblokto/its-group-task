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

inputs = {

  vpc_id = "${dependency.vpc.outputs.vpc_id}"

  name            = "${local.project}-${local.environment}-alb-sg"
  use_name_prefix = false
  description     = "${local.project}-${local.environment}-alb-sg"

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
    Name        = "${local.project}-${local.environment}-alb-sg"
    Project     = "${local.project}"
    Environment = "${local.environment}"
  }

}

dependencies {

  paths = [
    "..//ecr",
    "..//s3",
    "..//datasources",
    "..//vpc"
  ]
}