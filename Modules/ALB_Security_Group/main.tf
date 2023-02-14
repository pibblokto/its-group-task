resource "aws_security_group" "alb_security_group" {
  count       = length(var.ports_for_alb_sg) != 0 ? 1 : 0
  name        = "${var.project}-${var.environment}-alb-security-group"
  description = "${var.project}-${var.environment}-alb-security-group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ports_for_alb_sg
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-${var.environment}-alb-security-group"
  }

}
