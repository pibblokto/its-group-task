resource "aws_db_option_group" "database_option_group" {
  name                     = "${var.project}-${var.environment}-db-option-group"
  option_group_description = "${var.project}-${var.environment}-db-option-group"
  engine_name              = var.engine_name
  major_engine_version     = var.major_engine_version

  tags = {
    Name = "${var.project}-${var.environment}-db-option-group"
  }
}
