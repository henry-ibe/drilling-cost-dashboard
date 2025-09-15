# Subnet IDs discovered in the default VPC
output "subnet_ids" {
  value = data.aws_subnets.default.ids
}

# Security Group ID for ECS host/services
output "ecs_host_sg_id" {
  value = aws_security_group.ecs_host.id
}
