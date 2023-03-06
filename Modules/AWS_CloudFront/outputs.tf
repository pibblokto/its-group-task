#------------- CloudFront Cache Policy -------------#

output "cache_policy_id" {
  value = aws_cloudfront_cache_policy.example.id
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
