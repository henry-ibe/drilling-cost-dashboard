# -----------------------------------------------------------
# Outputs for Compute Module
# -----------------------------------------------------------

# ECS Cluster name (used by root module and services)
output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

# ECS Cluster ARN (used by scheduling module)
output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}
