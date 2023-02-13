locals {

  environment_vars = read_terragrunt_config(find_in_parent_folders("common_vars.hcl"))

}