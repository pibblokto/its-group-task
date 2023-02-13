output "alb-endpoint" {
  value = aws_alb.application_load_balancer.public_ip
}