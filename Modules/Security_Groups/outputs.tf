#---------- ALB Security Group ----------#
output "alb_security_group_id" {
  value = aws_security_group.alb_security_group[*].id
}




#---------- App Security Group ----------#
output "application_security_group_id" {
  value = aws_security_group.application_security_group[*].id
}




#---------- DB Security Group ----------#
output "database_security_group_id" {
  value = aws_security_group.database_security_group[*].id
}
