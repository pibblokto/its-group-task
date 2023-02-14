resource "aws_lb" "application_load_balancer" {
  name               = "${var.project}-${var.environment}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnets
  security_groups    = var.security_groups

  tags = {
    Name = "${var.project}-${var.environment}-alb"
  }
  depends_on = [aws_lb_target_group.target_group]
}

resource "aws_lb_target_group" "target_group" {
  name                 = "${var.project}-${var.environment}-tg"
  port                 = var.target_group_port
  protocol             = var.target_group_protocol
  target_type          = var.target_type
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay

  health_check {
    path                = var.health_check["path"]
    protocol            = var.target_group_protocol
    matcher             = var.health_check["matcher"]
    interval            = var.health_check["interval"]
    timeout             = var.health_check["timeout"]
    healthy_threshold   = var.health_check["healthy_threshold"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
  }

  tags = {
    Name = "${var.project}-${var.environment}-tg"
  }
}

resource "aws_lb_listener" "listener_https" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = var.https_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn
  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}



resource "aws_lb_listener" "redirection" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = var.alb_redirection_port
  protocol          = var.alb_redirection_port_protocol

  default_action {
    type = "redirect"

    redirect {
      port        = var.https_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
