resource "aws_db_parameter_group" "db_parameter_group" {
  name        = "${var.project}-${var.environment}-db-parameter-group"
  description = "${var.project}-${var.environment}-db-parameter-group"
  family      = var.family

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.project}-${var.environment}-db-parameter-group"
  }
}
