include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//RDS_Event_Subscription"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
}

include "sns_topic" {
  path           = "..//dependency_blocks/sns_topic.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "db_instance" {
  path           = "..//dependency_blocks/db_instance.hcl"
  expose         = true
  merge_strategy = "deep"
}


inputs = {

  sns_topic = dependency.sns_topic.outputs.sns_topic_arn

  source_type = "db-instance"
  source_ids  = [dependency.db_instance.outputs.database_instance_id]

  enabled = true

  event_categories = [
    "availability",
    "configuration change",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "security",
    "security patching"

  ]

}

dependencies {

  paths = [
    "..//option_group",
    "..//parameter_group",
    "..//vpc",
    "..//subnet_group",
    "..//security_groups",
    "..//db_instance",
    "..//sns_topic"
  ]
}