include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//SNS_Topic"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
}


inputs = {

  display_name = "RDS-Events"
  fifo_topic   = false

  sns_topic_subscription_protocol = "email"
  sns_topic_subscribers           = ["dmytrii.k@itsyndicate.org"]

}

dependencies {

  paths = [
    "..//option_group",
    "..//parameter_group",
    "..//vpc",
    "..//subnet_group",
    "..//security_groups",
    "..//db_instance"
  ]
}