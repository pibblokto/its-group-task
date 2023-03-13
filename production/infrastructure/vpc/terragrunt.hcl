include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc//.?ref=v3.19.0"
}

include "datasources" {
  path           = "..//dependency_blocks/datasources.hcl"
  expose         = true
  merge_strategy = "deep"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  project     = local.environment_vars.locals.project
  environment = local.environment_vars.locals.environment
}

inputs = {

  cidr            = "192.168.0.0/16"
  azs             = slice("${dependency.datasources.outputs.aws_availability_zones_names}", 0, 2)
  private_subnets = ["192.168.1.0/24","192.168.2.0/24"]
  public_subnets  = ["192.168.3.0/24","192.168.4.0/24"]
  
  enable_nat_gateway      = true
  single_nat_gateway      = true
  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true

  tags = {
    Project     = "${local.project}"
    Environment = "${local.environment}"
  }

  vpc_tags = {
    Name = "${local.project}-${local.environment}-vpc"
  }

  igw_tags = {
    Name = "${local.project}-${local.environment}-igw"
  }

  public_subnet_tags = {
    Name = "${local.project}-${local.environment}-public-subnet"
  }

  private_subnet_tags = {
    Name = "${local.project}-${local.environment}-private-subnet"
  }

  public_route_table_tags = {
    Name = "${local.project}-${local.environment}-public-route-table"
  }

  private_route_table_tags = {
    Name = "${local.project}-${local.environment}-private-route-table"
  }

  nat_gateway_tags = {
    Name = "${local.project}-${local.environment}-nat"
  }

  nat_eip_tags = {
    Name = "${local.project}-${local.environment}-elastic-ip"
  }
  
}

dependencies {

  paths = [
    "..//ecr",
    "..//s3",
    "..//datasources"
  ]
}
