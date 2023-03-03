resource "aws_ssm_parameter" "db_url" {
  name        = "${var.project}-${var.environment}_database_url"
  description = "${var.project}-${var.environment}_database_url"
  tier        = var.tier
  type        = var.type
  value       = "postgres://${var.db_username}:${var.db_password}@${var.db_endpoint}/${var.db_name}"

}
