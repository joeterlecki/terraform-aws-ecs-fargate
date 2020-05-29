output "ecs_cluster_cloud_watch_log_group_arn" {
  description = "The Cloud Watch Log Group ARN for the ecs cluster"
  value = aws_cloudwatch_log_group.ecs_task_log_group.arn
}

output "ecs_cluster_id" {
  description = "The ECS Cluster ID"
  value       = aws_ecs_cluster.ecs_cluster.id
}

output "ecs_cluster_arn" {
  description = "The ECS Cluster ARN"
  value       = aws_ecs_cluster.ecs_cluster.arn
}

output "ecs_service_id" {
  description = "The ECS service ARN"
  value       = aws_ecs_service.ecs_service.id
}

output "ecs_service_name" {
  description = "The ECS service name"
  value       = aws_ecs_service.ecs_service.name
}

output "ecs_service_cluster" {
  description = "The cluster the ecs service runs on"
  value       = aws_ecs_service.ecs_service.cluster
}

output "ecs_task_definition_arn" {
  description = "The ecs task definition ARN"
  value       = aws_ecs_task_definition.ecs_task_definition.arn
}

output "ecs_task_definition_family" {
  description = "The ecs definition family name"
  value       = aws_ecs_task_definition.ecs_task_definition.family
}

output "ecs_task_definition_revision" {
  description = "The task definition revision"
  value       = aws_ecs_task_definition.ecs_task_definition.revision
}