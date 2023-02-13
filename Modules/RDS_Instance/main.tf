resource "aws_db_instance" "db_instance" {
  identifier                      = "${var.project}-${var.environment}-database"
  db_name                         = var.db_name
  engine                          = var.engine
  engine_version                  = var.engine_version
  multi_az                        = var.multi_az
  username                        = var.username
  password                        = var.password
  instance_class                  = var.instance_class
  storage_type                    = var.storage_type
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  network_type                    = var.network_type
  db_subnet_group_name            = var.db_subnet_group_name
  publicly_accessible             = var.publicly_accessible
  vpc_security_group_ids          = var.vpc_security_group_ids
  availability_zone               = var.availability_zone
  ca_cert_identifier              = var.ca_cert_identifier
  port                            = var.port
  performance_insights_enabled    = var.performance_insights_enabled
  parameter_group_name            = var.parameter_group_name
  backup_retention_period         = var.backup_retention_period
  delete_automated_backups        = var.delete_automated_backups
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  storage_encrypted               = var.storage_encrypted
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  apply_immediately               = var.apply_immediately
  deletion_protection             = var.deletion_protection
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = var.final_snapshot_identifier
  backup_window                   = var.backup_window
  maintenance_window              = var.maintenance_window
  option_group_name               = var.option_group_name

  tags = {
    Name = "${var.project}-${var.environment}-database"
  }
}
