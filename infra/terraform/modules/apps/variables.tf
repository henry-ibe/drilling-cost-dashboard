# -----------------------------------------------------------
# Variables for Apps Module (ECS Task Definitions)
# -----------------------------------------------------------

# AWS region
variable "region" {
  type = string
}

# Prefix for naming ECS resources
variable "name_prefix" {
  type = string
}

# IAM roles
variable "task_exec_role" {
  type = string
}
variable "task_role" {
  type = string
}

# CloudWatch log group names
variable "log_group_api" {
  type = string
}
variable "log_group_dash" {
  type = string
}
variable "log_group_worker" {
  type = string
}

# Container ports
variable "api_port" {
  type = number
}
variable "dash_port" {
  type = number
}

# SSM parameters (ARN for JWT secret, Name for bucket)
variable "ssm_jwt_arn" {
  type = string
}
variable "ssm_bucket_name" {
  type = string
}
