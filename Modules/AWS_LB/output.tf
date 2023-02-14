output "alb_arn" {
  value = aws_lb_target_group.target_group.arn
  description = "The aws lb target group arn"
}