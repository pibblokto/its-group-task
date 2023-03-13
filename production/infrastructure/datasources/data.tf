#------------- Data Sources -------------#

data "aws_availability_zones" "available" {}

data "aws_ssm_parameter" "postgres_db" {
  name = "${var.project}-${var.environment}_postgres_db"
}

data "aws_ssm_parameter" "database_username" {
  name = "${var.project}-${var.environment}_database_username"
}

data "aws_ssm_parameter" "database_password" {
  name = "${var.project}-${var.environment}_database_password"
}

