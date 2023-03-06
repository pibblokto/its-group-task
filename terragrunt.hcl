skip = true

locals {
  # Automatically load environment-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract out common variables for reuse
  aws_region = local.region_vars.locals.aws_region
  profile    = local.region_vars.locals.profile
}

remote_state {

  backend  = "s3"

  generate = {

    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"

  }

  config = {
    bucket  = "project-terraform-tfstate"
    region  = "eu-central-1"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    encrypt = true

  }
}

generate "provider" {

  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  
  contents  = <<EOF
provider "aws" {
  region  = "${local.aws_region}"
  profile = "${local.profile}"
}
EOF
}
