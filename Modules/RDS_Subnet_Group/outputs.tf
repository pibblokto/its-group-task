output "subnet_group_id" {
  value = aws_db_subnet_group.db_subnet_group.id
}

output "subnet_group_arn" {
  value = aws_db_subnet_group.db_subnet_group.arn
}
