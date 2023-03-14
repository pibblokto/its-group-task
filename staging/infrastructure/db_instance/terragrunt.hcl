include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-rds//.?ref=v5.6.0"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  project     = local.environment_vars.locals.project
  environment = local.environment_vars.locals.environment
}

include "datasources" {
  path           = "..//dependency_blocks/datasources.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "vpc" {
  path           = "..//dependency_blocks/vpc.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "db_security_group" {
  path           = "..//dependency_blocks/db_security_group.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {

  # Option Group
  create_db_option_group = false

  # Parameter Group 
  create_db_parameter_group       = true
  parameter_group_name            = "${local.project}-${local.environment}-parameter-group"
  parameter_group_description     = "${local.project}-${local.environment}-parameter-group"
  family                          = "postgres14"
  parameter_group_use_name_prefix = false

  # Subnet Group
  create_db_subnet_group          = true
  db_subnet_group_name            = "${local.project}-${local.environment}-subnet-group"
  db_subnet_group_description     = "${local.project}-${local.environment}-subnet-group"
  subnet_ids                      = "${dependency.vpc.outputs.private_subnets}"
  db_subnet_group_use_name_prefix = false

  # DB Instance
  identifier                          = "${local.project}-${local.environment}-database" 
  allocated_storage                   = 20
  storage_type                        = "gp3"
//   storage_throughput = 125    #To provision additional IOPS and throughput, increase the allocated storage to 400 GiB or greater.
  storage_encrypted                   = true
  iam_database_authentication_enabled = false
  engine                              = "postgres"
  engine_version                      = "14.6"
  skip_final_snapshot                 = true
  final_snapshot_identifier           = null
  copy_tags_to_snapshot               = true
  instance_class                      = "db.t3.micro"
  db_name                             = "${dependency.datasources.outputs.postgres_db}"
  username                            = "${dependency.datasources.outputs.database_username}"
  password                            = "${dependency.datasources.outputs.database_password}"
  port                                = 5432
  vpc_security_group_ids              = ["${dependency.db_security_group.outputs.security_group_id}"]
  availability_zone                   = "us-east-1a"
  multi_az                            = false
//   iops = 3000       # To provision additional IOPS and throughput, increase the allocated storage to 400 GiB or greater.
  publicly_accessible                 = false
  allow_major_version_upgrade         = false
  auto_minor_version_upgrade          = true
  apply_immediately                   = false
  maintenance_window                  = "Sun:00:00-Sun:02:00"
  backup_retention_period             = 7
  backup_window                       = "02:00-03:00"
  enabled_cloudwatch_logs_exports     = []
  deletion_protection                 = false
  performance_insights_enabled        = false
  max_allocated_storage               = 100
  ca_cert_identifier                  = "rds-ca-2019"
  delete_automated_backups            = true
  network_type                        = "IPV4"
  create_random_password              = false

  tags = {
    Project     = "${local.project}"
    Environment = "${local.environment}"
  }

  db_parameter_group_tags = {
    Name = "${local.project}-${local.environment}-parameter-group"
  }

  db_subnet_group_tags = {
    Name = "${local.project}-${local.environment}-subnet-group"
  }

  db_instance_tags = {
    Name = "${local.project}-${local.environment}-database"
  }

}

dependencies {

  paths = [
    "..//ecr",
    "..//s3",  
    "..//datasources",
    "..//vpc",
    "..//alb_security_group",
    "..//app_security_group",
    "..//db_security_group"
  ]
}
