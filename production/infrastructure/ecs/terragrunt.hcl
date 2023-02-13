include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//ECS_Fargate"
}

dependencies {
  paths = ["../vpc"] 
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  replicaCount = 1
  memory = 1024
  cpu = 512
  vpcId =   dependency.vpc.outputs.main_vpc_id
  subnetId = dependency.vpc.outputs.private_subnets_ids
}