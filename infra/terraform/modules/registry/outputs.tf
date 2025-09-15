# -----------------------------------------------------------
# Outputs for Registry Module
# -----------------------------------------------------------

output "ecr_api" {
  value = aws_ecr_repository.api.repository_url
}

output "ecr_dash" {
  value = aws_ecr_repository.dash.repository_url
}

output "ecr_worker" {
  value = aws_ecr_repository.worker.repository_url
}
