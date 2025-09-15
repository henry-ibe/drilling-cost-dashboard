# -----------------------------------------------------------
# Services Module: ECS Services for API and Dashboard
# -----------------------------------------------------------

# API Service
resource "aws_ecs_service" "api" {
  name            = "api"
  cluster         = var.cluster_name
  task_definition = var.api_td_arn
  desired_count   = var.api_desired_count
  launch_type     = "EC2"

  scheduling_strategy = "REPLICA"
  force_new_deployment = true

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}

# Dashboard Service
resource "aws_ecs_service" "dash" {
  name            = "dash"
  cluster         = var.cluster_name
  task_definition = var.dash_td_arn
  desired_count   = var.dash_desired_count
  launch_type     = "EC2"

  scheduling_strategy = "REPLICA"
  force_new_deployment = true

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}
