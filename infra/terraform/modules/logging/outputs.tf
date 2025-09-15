# -----------------------------------------------------------
# Outputs for Logging Module
# -----------------------------------------------------------

output "log_group_api" {
  value = aws_cloudwatch_log_group.api.name
}

output "log_group_dash" {
  value = aws_cloudwatch_log_group.dash.name
}

output "log_group_worker" {
  value = aws_cloudwatch_log_group.worker.name
}
