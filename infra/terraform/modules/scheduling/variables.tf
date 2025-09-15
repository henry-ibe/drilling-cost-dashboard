# -----------------------------------------------------------
# Variables for Scheduling Module (EventBridge → Worker Task)
# -----------------------------------------------------------

# AWS region
variable "region" {
  type = string
}

# Prefix for naming EventBridge resources
variable "name_prefix" {
  type = string
}

# ECS cluster ARN where the worker will run
variable "cluster_arn" {
  type = string
}

# ARN of the worker ECS task definition
variable "worker_td_arn" {
  type = string
}

# Schedule expression (e.g., "rate(5 minutes)")
variable "schedule_expr" {
  type = string
}
