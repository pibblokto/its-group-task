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

include "alb_security_group" {
  path           = "..//dependency_blocks/alb_security_group.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  
  # Security Group
  vpc_id = dependency.vpc.outputs.main_vpc_id
  security_group_name = "app-sg"
  security_group_description = "app-sg"


  # Ingress rule with source security group
  ingress_with_source_sg_rule_from_ports = ["8000"]
  ingress_with_source_sg_rule_to_ports = ["8000"]
  ingress_with_source_sg_rule_protocols = ["tcp"]
  ingress_with_source_sg_rule_security_groups = [dependency.alb_security_group.outputs.security_group_id]
  ingress_with_source_sg_rule_description = ["Allow all inbound traffic from ALB SG"]


  # Egress rule with CIDR Blocks
  egress_with_cidr_rule_from_ports = ["0"]
  egress_with_cidr_rule_to_ports = ["0"]
  egress_with_cidr_rule_protocols = ["-1"]
  egress_with_cidr_rule_cidr_blocks = ["0.0.0.0/0"]
  egress_with_cidr_rule_description = ["Allow all outbound traffic"]
  
}

dependencies {

  paths = [
    "..//vpc",
    "..//alb_security_group"
  ]
}