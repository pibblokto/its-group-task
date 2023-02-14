include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//App_Security_Group"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
}

include "vpc" {
  path           = "..//dependency_blocks/vpc.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "alb_security_group" {
  path           = "..//dependency_blocks/alb_security_group.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  vpc_id = dependency.vpc.outputs.main_vpc_id

  ports_for_application_sg = ["8000"]

  alb_security_group_id = dependency.alb_security_group.outputs.alb_security_group_id

}

dependencies {

  paths = [
    "..//vpc",
    "..//alb_security_group"
  ]
}