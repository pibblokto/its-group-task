resource "aws_security_group" "service_sg" {
  vpc_id = var.vpcId

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-service-sg"
  }
}

resource "aws_security_group" "load_balancer_sg" {
  vpc_id = var.vpcId

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name        = "${var.project}-${var.environment}-alb-sg"
  }
}
###############################################################################################

resource "aws_alb" "application_load_balancer" {
  name               = "${var.project}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.subnetId]
  security_groups    = [aws_security_group.load_balancer_sg.id]

  tags = {
    Name        = "${var.project}-${var.environment}-alb"
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.project}-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpcId

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-tg"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
  }
}
###########################################################################

resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.project}-${var.environment}-ecs"
  tags = {
    Name        = "${var.project}-${var.environment}-ecs"
  }
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${var.project}-${var.environment}-task"

    container_definitions = file("task-definition.json")


  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  tags = {
    Name        = "${var.project}-${var.environment}-task"
  }
}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.aws-ecs-task.family
}

resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "${var.project}-${var.environment}-service"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = aws_ecs_task_definition.aws-ecs-task.arn
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = var.replicaCount
  force_new_deployment = true

  network_configuration {
    subnets          = [var.subnetId]
    security_groups = [
      aws_security_group.service_sg.id,
      aws_security_group.load_balancer_sg.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.listener]
}