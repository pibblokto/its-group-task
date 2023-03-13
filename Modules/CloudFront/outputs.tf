#------------- CloudFront ALB Cache Policy -------------#

output "alb_cache_policy_id" {
  value = aws_cloudfront_cache_policy.alb.id
}

#------------- S3 Origin Access Control -------------#

output "s3_origin_access_control_id" {
  value = aws_cloudfront_origin_access_control.s3_access_control.id
}

#------------- CloudFront S3 Cache Policy -------------#

output "s3_cache_policy_id" {
  value = aws_cloudfront_cache_policy.s3.id
}

#------------- CloudFront Distribution -------------#

output "distribution_id" {
  value = aws_cloudfront_distribution.cloudfront_distribution.id
}

output "distribution_arn" {
  value = aws_cloudfront_distribution.cloudfront_distribution.arn
}

output "distribution_caller_reference" {
  value = aws_cloudfront_distribution.cloudfront_distribution.caller_reference
}

output "distribution_status" {
  value = aws_cloudfront_distribution.cloudfront_distribution.status
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}
