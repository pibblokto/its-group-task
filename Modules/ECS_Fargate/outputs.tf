output "ecs_cluster_id" {
  value = aws_ecs_cluster.aws-ecs-cluster.id
}

output "task_definition_id" {
  value = aws_ecs_task_definition.aws-ecs-task.id
}



output "task_definition_arn" {
  value = aws_ecs_task_definition.aws-ecs-task.arn
}
