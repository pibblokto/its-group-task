#------------- RDS Option Group -------------#
output "option_group_id" {
  value = aws_db_option_group.database_option_group.id
}

output "option_group_arn" {
  value = aws_db_option_group.database_option_group.arn
}



#------------- RDS Parameter Group -------------#
output "parameter_group_id" {
  value = aws_db_parameter_group.db_parameter_group.id
}

output "parameter_group_arn" {
  value = aws_db_parameter_group.db_parameter_group.arn
}




#------------- RDS Subnet Group -------------#
output "subnet_group_id" {
  value = aws_db_subnet_group.db_subnet_group.id
}

output "subnet_group_arn" {
  value = aws_db_subnet_group.db_subnet_group.arn
}




#------------- RDS Instance -------------#

output "database_address" {
  value     = aws_db_instance.db_instance.address
  sensitive = true
}

output "database_arn" {
  value = aws_db_instance.db_instance.arn
}

output "database_endpoint" {
  value     = aws_db_instance.db_instance.endpoint
  sensitive = true
}

output "database_backup_window" {
  value = aws_db_instance.db_instance.backup_window
}

output "database_maintenance_window" {
  value = aws_db_instance.db_instance.maintenance_window
}

output "database_instance_id" {
  value = aws_db_instance.db_instance.id
}

output "database_instance_db_name" {
  value     = aws_db_instance.db_instance.db_name
  sensitive = true
}

output "database_identifier" {
  value = aws_db_instance.db_instance.identifier
}

output "database_status" {
  value = aws_db_instance.db_instance.status
}
