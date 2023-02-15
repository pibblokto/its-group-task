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

resource "aws_iam_role_policy" "parameter_store_access_policy" {
  name = "parameter_store_access"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:GetParameters",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:ssm:${var.aws_region}:${var.account_id}:parameter/${var.project}-${var.environment}_*"

        ]
      },
    ]
  })
}

resource "aws_iam_role_policy" "s3_bucket_access_policy" {
  name = "s3_bucket_access_policy"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "s3-object-lambda:*",
        ]
        Effect   = "Allow"
        Resource = "${var.s3_bucket_arn}/*"

      },
    ]
  })
}


// -----------------------------------------------------
resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.project}-${var.environment}-cluster"
  tags = {
    Name = "${var.project}-${var.environment}-cluster"
  }
}


resource "aws_ecs_task_definition" "aws-ecs-task" {
  family                   = "${var.project}-${var.environment}-task-definiton"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = [var.launch_type]
  network_mode             = var.network_mode
  memory                   = var.memory
  cpu                      = var.cpu

  container_definitions = jsonencode([
    {
      name      = "${var.main_container_name}"
      image     = "${var.ecr_uri}"
      essential = true
      environment = [
        { "name" : "DEBUG", "value" : "False" },
        { "name" : "DJANGO_ALLOWED_HOSTS", "value" : "*" },
        { "name" : "DEVELOPMENT_MODE", "value" : "False" }
      ]
      secrets = [
        { "name" : "DATABASE_URL", "valueFrom" : "${var.project}-${var.environment}_database_url" },
        { "name" : "DJANGO_SECRET_KEY", "valueFrom" : "${var.project}-${var.environment}_django_secret_key" }
      ]
      portMappings = [
        {
          containerPort = var.main_container_port
          hostPort      = var.main_container_port
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.project}-${var.environment}-task-definition"
  }

  depends_on = [
    aws_ecs_cluster.aws-ecs-cluster
  ]

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

    subnets          = var.subnets
    security_groups  = var.ecs_security_groups
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.main_container_name
    container_port   = var.main_container_port
  }

}



#-------------- ECS service targetting -----------------------

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${aws_ecs_cluster.aws-ecs-cluster.name}/${aws_ecs_service.aws-ecs-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

}



#-------------- ECS service auto scaling policy -----------------------

resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "${var.project}-${var.environment}-auto-scaling-policy"
  policy_type        = var.appautoscaling_policy_type
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.target_value
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }
  }

}
