include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//Parameter_Store"
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

include "db_instance" {
  path           = "..//dependency_blocks/db_instance.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {

  project     = "${local.project}"
  environment = "${local.environment}"

  tier        = "Standard"
  type        = "SecureString"
  db_username = "${dependency.datasources.outputs.database_username}"
  db_password = "${dependency.datasources.outputs.database_password}"
  db_endpoint = "${dependency.db_instance.outputs.db_instance_endpoint}"
  db_name     = "${dependency.datasources.outputs.postgres_db}"

}

dependencies {

  paths = [
    "..//ecr",
    "..//datasources",
    "..//vpc",
    "..//alb_security_group",
    "..//app_security_group",
    "..//db_security_group",
    "..//alb",
    "..//db_instance"
  ]
}
