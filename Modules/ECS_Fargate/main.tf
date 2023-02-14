resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.project}-${var.environment}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
// -----------------------------------------------------
resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.project}-${var.environment}-ecs"
  tags = {
    Name = "${var.project}-${var.environment}-ecs"
  }
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${var.project}-${var.environment}-task"

  container_definitions    = <<DEFINITION

  [
    {
      "name": "nginx",
      "image": "nginx:alpine",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "networkMode": "awsvpc",
      "memory": 1024,
      "cpu": 1024
    }
  ]
DEFINITION
  requires_compatibilities = [var.launch_type]
  network_mode             = var.network_mode
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  tags = {
    Name = "${var.project}-${var.environment}-task"
  }
}



resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "${var.project}-${var.environment}-service"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = aws_ecs_task_definition.aws-ecs-task.arn
  launch_type          = var.launch_type
  scheduling_strategy  = var.scheduling_strategy
  desired_count        = var.desired_count
  force_new_deployment = true

  network_configuration {

    subnets         = var.subnetId
    security_groups = var.ecs_security_groups
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}
