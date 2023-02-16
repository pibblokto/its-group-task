include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//RDS_Instance"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
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
  engine_name          = "postgres"
  major_engine_version = "13"


  # Parameter Group 
  family = "postgres13"


  # Subnet Group
  subnet_ids = dependency.vpc.outputs.private_subnets_ids


  # DB Instance
  postgres_db                     = "postgres_db"
  database_username               = "database_username"
  database_password               = "database_password"
  engine                          = "postgres"
  engine_version                  = "13.7"
  multi_az                        = false
  instance_class                  = "db.t3.micro"
  storage_type                    = "gp2"
  allocated_storage               = 20
  max_allocated_storage           = 100
  network_type                    = "IPV4"
  publicly_accessible             = false
  vpc_security_group_ids          = [dependency.db_security_group.outputs.security_group_id]
  availability_zone               = "us-east-1a"
  ca_cert_identifier              = "rds-ca-2019"
  port                            = 5432
  performance_insights_enabled    = false
  backup_retention_period         = 7
  delete_automated_backups        = true
  copy_tags_to_snapshot           = true
  storage_encrypted               = true
  enabled_cloudwatch_logs_exports = []
  auto_minor_version_upgrade      = true
  apply_immediately               = true
  deletion_protection             = false
  skip_final_snapshot             = true
  final_snapshot_identifier       = null
  backup_window                   = "02:00-03:00"
  maintenance_window              = "Sun:00:00-Sun:02:00"

}

dependencies {

  paths = [
    "..//vpc",
    "..//alb_security_group",
    "..//app_security_group",
    "..//db_security_group"
  ]
}