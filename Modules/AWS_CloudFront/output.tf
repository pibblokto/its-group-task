output "id" {
    value = aws_cloudfront_distribution.cloudfront_distribution.id
}

output "arn" {
    value = aws_cloudfront_distribution.cloudfront_distribution.arn
}

output "caller_reference " {
    value = aws_cloudfront_distribution.cloudfront_distribution.caller_reference 
}

output "status" {
    value = aws_cloudfront_distribution.cloudfront_distribution.status
}

output "domain_name" {
    value = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}