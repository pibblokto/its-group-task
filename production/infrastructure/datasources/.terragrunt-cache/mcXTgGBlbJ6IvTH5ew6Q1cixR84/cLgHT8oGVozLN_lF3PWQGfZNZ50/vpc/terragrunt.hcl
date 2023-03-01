include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc//.?ref=v3.19.0"
}


include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
  expose = true
}

include "datasources" {
  path           = "..//dependency_blocks/datasources.hcl"
  expose         = true
  merge_strategy = "deep"
}


inputs = {

  cidr        = "192.168.0.0/16"
  
  azs = slice(dependency.datasources.outputs.aws_availability_zones_names, 0, 2)
  private_subnets = ["192.168.1.0/24","192.168.2.0/24"]
  public_subnets  = ["192.168.3.0/24","192.168.4.0/24"]
  
  enable_nat_gateway = true

  single_nat_gateway   = true

  enable_dns_hostnames = true

  enable_dns_support = true

  map_public_ip_on_launch = true

  tags = {
    Project = "${include.envcommon.locals.environment_vars.locals.project}"
    Environment = "${include.envcommon.locals.environment_vars.locals.environment}"
  }

  vpc_tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-vpc"
  }

  igw_tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-igw"
  }

  public_subnet_tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-public-subnet"
  }

  private_subnet_tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-private-subnet"
  }

  public_route_table_tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-public-route-table"
  }

  private_route_table_tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-private-route-table"
  }

  nat_gateway_tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-nat"
  }

  nat_eip_tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-elastic-ip"
  }
}