resource "aws_s3_bucket" "main" {
  bucket = "${var.project}-${var.environment}-${var.bucket_name}"

}

resource "aws_s3_bucket_acl" "private_acl" {
  bucket = aws_s3_bucket.main.id
  acl    = var.acl
}

resource "aws_s3_bucket_versioning" "versioning_enabled" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.main.id
  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
