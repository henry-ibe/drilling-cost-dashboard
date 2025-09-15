# -----------------------------------------------------------
# Logging Module: CloudWatch Log Groups (API, Dashboard, Worker)
# -----------------------------------------------------------

resource "aws_cloudwatch_log_group" "api" {
  name              = "/ecs/${var.name_prefix}/api"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "dash" {
  name              = "/ecs/${var.name_prefix}/dash"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "worker" {
  name              = "/ecs/${var.name_prefix}/worker"
  retention_in_days = 14
}
