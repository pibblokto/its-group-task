output "parameter_arn" {
  value = aws_ssm_parameter.db_url.arn
}

output "parameter_value" {
  value     = aws_ssm_parameter.db_url.value
  sensitive = true
}
