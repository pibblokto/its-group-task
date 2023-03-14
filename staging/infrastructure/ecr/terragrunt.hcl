include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-ecr//.?ref=v1.6.0"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  project     = local.environment_vars.locals.project
  environment = local.environment_vars.locals.environment
}

inputs = {

  repository_type                 = "private"
  repository_name                 = "${local.project}-${local.environment}-ecr"
  repository_image_tag_mutability = "IMMUTABLE"
  repository_image_scan_on_push   = true
  repository_force_delete         = false

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
    Project     = "${local.project}"
    Environment = "${local.environment}"
  }

}
