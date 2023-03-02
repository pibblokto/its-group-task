data "aws_availability_zones" "available" {}

data "aws_ssm_parameter" "postgres_db" {
  name = "team-task-production_postgres_db"
}

data "aws_ssm_parameter" "database_username" {
  name = "team-task-production_database_username"
}

data "aws_ssm_parameter" "database_password" {
  name = "team-task-production_database_password"
}




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
