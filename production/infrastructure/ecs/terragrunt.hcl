include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//ECS_Fargate"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
}

include "vpc" {
  path           = "..//dependency_blocks/vpc.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "app_security_group" {
  path           = "..//dependency_blocks/app_security_group.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "alb" {
  path           = "..//dependency_blocks/alb.hcl"
  expose         = true
  merge_strategy = "deep"
}

include "s3" {
  path           = "..//dependency_blocks/s3.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {

  # S3 Bucket
  s3_bucket_arn = dependency.s3.outputs.s3_bucket_arn

  # Task Definition
  launch_type = "FARGATE"
  network_mode = "awsvpc"
  cpu = "256"
  memory = "512"
  init_container_name = "migration"
  ecr_uri = "piblokto/django_app:latest"
  init_container_command = ["python", "manage.py", "migrate"]

  main_container_name = "django-app"
  main_container_port = 8000
  init_container_execution_condition = "SUCCESS"

  # ECS Service
  scheduling_strategy = "REPLICA"
  desired_count = 2
  subnets = dependency.vpc.outputs.private_subnets_ids
  ecs_security_groups = dependency.app_security_group.outputs.application_security_group_id
  alb_target_group_arn = dependency.alb.outputs.alb_target_group_arn

  # ECS Service Autoscaling
  max_capacity = 3
  min_capacity = 2
  appautoscaling_policy_type = "TargetTrackingScaling"
  target_value = 70
  predefined_metric_type = "ECSServiceAverageCPUUtilization"



}

dependencies {

  paths = [
    "..//s3",
    "..//vpc",
    "..//alb_security_group",
    "..//app_security_group",
    "..//db_security_group",
    "..//alb",
    "..//db_instance"
  ]
}