include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//Security_Groups"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
}

include "vpc" {
  path           = "..//dependency_blocks/vpc.hcl"
  expose         = true
  merge_strategy = "deep"
}


inputs = {
  vpc_id = dependency.vpc.outputs.main_vpc_id

  ports_for_alb_sg = ["80", "443"]

  ports_for_application_sg = ["8000"]

  ports_for_database_sg = ["5432"]

}

dependencies {

  paths = [
    "..//vpc"
  ]
}