output "s3_bucket_name" {
  value = aws_s3_bucket.main.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "s3_bucket_region" {
  value = aws_s3_bucket.main.region
}
