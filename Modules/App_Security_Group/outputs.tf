output "application_security_group_id" {
  value = aws_security_group.application_security_group[0].id
}
