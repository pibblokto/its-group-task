output "database_address" {
  value = aws_db_instance.db_instance.address
}

output "database_arn" {
  value = aws_db_instance.db_instance.arn
}

output "database_endpoint" {
  value = aws_db_instance.db_instance.endpoint
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
  value = aws_db_instance.db_instance.db_name
}

output "database_identifier" {
  value = aws_db_instance.db_instance.identifier
}

output "database_status" {
  value = aws_db_instance.db_instance.status
}
