output "api_td_arn" {
  value = aws_ecs_task_definition.api.arn
}
output "dash_td_arn" {
  value = aws_ecs_task_definition.dash.arn
}
output "worker_td_arn" {
  value = aws_ecs_task_definition.worker.arn
}
