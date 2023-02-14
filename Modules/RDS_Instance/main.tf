#------------- Data Sources -------------#

data "aws_ssm_parameter" "postgres_db" {
  name = "/${var.project}/${var.environment}/${var.postgres_db}"
}

data "aws_ssm_parameter" "database_username" {
  name = "/${var.project}/${var.environment}/${var.database_username}"
}

data "aws_ssm_parameter" "database_password" {
  name = "/${var.project}/${var.environment}/${var.database_password}"
}


#------------- RDS Option Group -------------#
resource "aws_db_option_group" "database_option_group" {
  name                     = "${var.project}-${var.environment}-db-option-group"
  option_group_description = "${var.project}-${var.environment}-db-option-group"
  engine_name              = var.engine_name
  major_engine_version     = var.major_engine_version

  tags = {
    Name = "${var.project}-${var.environment}-db-option-group"
  }
}




#------------- RDS Parameter Group -------------#

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




#------------- RDS Subnet Group -------------#

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.project}-${var.environment}-subnet-group"
  description = "${var.project}-${var.environment}-subnet-group"
  subnet_ids  = var.subnet_ids

  tags = {
    Name = "${var.project}-${var.environment}-subnet-group"
  }
}






#------------- RDS Instance -------------#
resource "aws_db_instance" "db_instance" {
  identifier                      = "${var.project}-${var.environment}-database"
  db_name                         = data.aws_ssm_parameter.postgres_db.value
  engine                          = var.engine
  engine_version                  = var.engine_version
  multi_az                        = var.multi_az
  username                        = data.aws_ssm_parameter.database_username.value
  password                        = data.aws_ssm_parameter.database_password.value
  instance_class                  = var.instance_class
  storage_type                    = var.storage_type
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  network_type                    = var.network_type
  db_subnet_group_name            = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible             = var.publicly_accessible
  vpc_security_group_ids          = var.vpc_security_group_ids
  availability_zone               = var.availability_zone
  ca_cert_identifier              = var.ca_cert_identifier
  port                            = var.port
  performance_insights_enabled    = var.performance_insights_enabled
  parameter_group_name            = aws_db_parameter_group.db_parameter_group.name
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
  option_group_name               = aws_db_option_group.database_option_group.name

  tags = {
    Name = "${var.project}-${var.environment}-database"
  }
}
