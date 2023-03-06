include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-s3-bucket//.?ref=v3.7.0"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  project     = local.environment_vars.locals.project
  environment = local.environment_vars.locals.environment
}

inputs = {

  bucket_prefix = "${local.project}-${local.environment}-bucket-"
  acl           = "private"
  versioning    = {
    enabled = true
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  server_side_encryption_configuration = {
    rule = {
        bucket_key_enabled                      = true
        apply_server_side_encryption_by_default = {
          sse_algorithm = "AES256"
        }
    }
  }

  tags = {
    Name        = "${local.project}-${local.environment}-bucket"
    Project     = "${local.project}"
    Environment = "${local.environment}"
  }
}
