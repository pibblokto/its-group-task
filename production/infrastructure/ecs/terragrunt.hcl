include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "${dirname(find_in_parent_folders())}//Modules//ECS_Fargate"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  config_vars      = read_terragrunt_config(find_in_parent_folders("config.hcl"))

  # Extract out common variables for reuse
  project     = local.environment_vars.locals.project
  environment = local.environment_vars.locals.environment
  aws_region  = local.region_vars.locals.aws_region
  account_id  = local.config_vars.locals.account_id
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

  project     = "${local.project}"
  environment = "${local.environment}"
  aws_region  = "${local.aws_region}"
  account_id  = "${local.account_id}"

  # S3 Bucket
  s3_bucket_arn = "${dependency.s3.outputs.s3_bucket_arn}"

  # Task Definition
  launch_type         = "FARGATE"
  network_mode        = "awsvpc"
  cpu                 = "256"
  memory              = "512"
  ecr_uri             = "piblokto/django_app:latest"
  main_container_name = "django-app"
  main_container_port = 8000

  # ECS Service
  scheduling_strategy  = "REPLICA"
  desired_count        = 2
  subnets              = "${dependency.vpc.outputs.private_subnets}"
  ecs_security_groups  = ["${dependency.app_security_group.outputs.security_group_id}"]
  alb_target_group_arn = "${dependency.alb.outputs.target_group_arns[0]}"

  # ECS Service Autoscaling
  max_capacity               = 3
  min_capacity               = 2
  appautoscaling_policy_type = "TargetTrackingScaling"
  target_value               = 70
  predefined_metric_type     = "ECSServiceAverageCPUUtilization"

}

dependencies {

  paths = [
    "..//s3",
    "..//datasources",
    "..//vpc",
    "..//alb_security_group",
    "..//app_security_group",
    "..//db_security_group",
    "..//alb",
    "..//db_instance",
    "..//parameter_store"
  ]
}
