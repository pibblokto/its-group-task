include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-ecr//.?ref=v1.6.0"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
  expose = true
}

inputs = {

  repository_type = "private"
  repository_name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-ecr"
  repository_image_tag_mutability = "IMMUTABLE"
  repository_image_scan_on_push = true
  repository_force_delete = false

  create_repository_policy = false
  attach_repository_policy = false

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "For `latest` tag, keep last 15 images",
        selection = {
          tagStatus     = "any",
          countType     = "imageCountMoreThan",
          countNumber   = 15
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Project = "${include.envcommon.locals.environment_vars.locals.project}"
    Environment = "${include.envcommon.locals.environment_vars.locals.environment}"
  }
}