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

  # Security Group
  vpc_id = dependency.vpc.outputs.main_vpc_id
  security_group_name = "alb-sg"
  security_group_description = "alb-sg"


  # Ingress rule with CIDR Blocks
  ingress_with_cidr_rule_from_ports = ["80", "443"]
  ingress_with_cidr_rule_to_ports = ["80", "443"]
  ingress_with_cidr_rule_protocols = ["tcp", "tcp"]
  ingress_with_cidr_rule_cidr_blocks = ["0.0.0.0/0", "0.0.0.0/0"]
  ingress_with_cidr_rule_description = ["Allow all inbound traffic", "Allow all inbound traffic"]


  # Egress rule with CIDR Blocks
  egress_with_cidr_rule_from_ports = ["0"]
  egress_with_cidr_rule_to_ports = ["0"]
  egress_with_cidr_rule_protocols = ["-1"]
  egress_with_cidr_rule_cidr_blocks = ["0.0.0.0/0"]
  egress_with_cidr_rule_description = ["Allow all outbound traffic"]

}

dependencies {

  paths = [
    "..//vpc"
  ]
}