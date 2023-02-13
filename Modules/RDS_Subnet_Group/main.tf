resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.project}-${var.environment}-subnet-group"
  description = "${var.project}-${var.environment}-subnet-group"
  subnet_ids  = var.subnet_ids

  tags = {
    Name = "${var.project}-${var.environment}-subnet-group"
  }
}
