resource "aws_lb" "application_load_balancer" {
  name               = "${var.project}-${var.environment}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnetId
  security_groups    = var.securityGroups

  tags = {
    Name        = "${var.project}-${var.environment}-alb"
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.project}-${var.environment}-tg"
  port        = var.http_port
  protocol    = "HTTP"
  target_type = var.target_type
  vpc_id      = var.vpcId

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 30
    timeout = 10
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
  depends_on = [aws_lb.application_load_balancer]

  tags = {
    Name        = "${var.project}-${var.environment}-tg"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.application_load_balancer.id
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
  }
}