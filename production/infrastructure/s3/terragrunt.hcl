include "root" {
  path = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}


terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-s3-bucket//.?ref=v3.7.0"
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
  expose = true
}

inputs = {

  bucket_prefix = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-static-content-"
  acl = "private"
  versioning = {
    enabled = true
  }

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true

  server_side_encryption_configuration = {
    rule = {
        bucket_key_enabled = true
        apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
        }
    }
  }

  tags = {
    Name = "${include.envcommon.locals.environment_vars.locals.project}-${include.envcommon.locals.environment_vars.locals.environment}-static-content-bucket"
    Project = "${include.envcommon.locals.environment_vars.locals.project}"
    Environment = "${include.envcommon.locals.environment_vars.locals.environment}"
  }
}