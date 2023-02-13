output "application_security_group_id" {
  value = aws_security_group.application_security_group[0].id
}

output "database_security_group_id" {
  value = aws_security_group.database_security_group[0].id
}

output "alb_security_group_id" {
  value = aws_security_group.alb_security_group[0].id
}
