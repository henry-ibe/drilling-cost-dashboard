# -----------------------------------------------------------
# Variables for Compute Module (ECS Cluster, Launch Template, ASG)
# -----------------------------------------------------------

# AWS region
variable "region" {
  type = string
}

# Prefix for naming ECS resources
variable "name_prefix" {
  type = string
}

# Common tags applied to all compute resources
variable "tags" {
  type = map(string)
}

# EC2 instance type for ECS host(s)
variable "instance_type" {
  type = string
}

# IAM Instance Profile name for ECS hosts
variable "iam_instance_prof" {
  type = string
}

# Security Group ID for ECS hosts
variable "sg_id" {
  type = string
}

# Subnets for ECS host placement
variable "subnets" {
  type = list(string)
}
