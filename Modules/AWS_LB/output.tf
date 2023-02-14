output "alb_target_group_arn" {
  value       = aws_lb_target_group.target_group.arn
  description = "AWS ALB target group ARN"
}

output "alb_dns_name" {
  value       = aws_lb.application_load_balancer.dns_name
  description = "AWS ALB DNS name"
}

output "alb_arn" {
  value       = aws_lb.application_load_balancer.arn
  description = "AWS ALB ARN"
}
