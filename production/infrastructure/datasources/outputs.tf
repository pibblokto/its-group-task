output "aws_availability_zones_names" {
  value = data.aws_availability_zones.available.names
}

output "postgres_db" {
  value     = data.aws_ssm_parameter.postgres_db.value
  sensitive = true
}

output "database_username" {
  value     = data.aws_ssm_parameter.database_username.value
  sensitive = true
}

output "database_password" {
  value     = data.aws_ssm_parameter.database_password.value
  sensitive = true
}
