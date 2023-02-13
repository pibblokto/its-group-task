skip = true


locals {

  environment_vars = read_terragrunt_config(find_in_parent_folders("common_vars.hcl"))

  aws_region = local.environment_vars.locals.aws_region

  profile = local.environment_vars.locals.profile

}




remote_state {

  backend = "s3"

  generate = {

    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"

  }


  config = {
    #project-terraform-tfstate
    bucket  = "state-bucket-asidj23ad"
    region  = "us-east-1"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    encrypt = true

  }
}




generate "provider" {

  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  profile = "${local.profile}"
}
EOF
}

inputs = merge(
  local.environment_vars.locals,
)