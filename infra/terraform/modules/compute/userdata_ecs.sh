#!/bin/bash
set -eux

# -----------------------------------------------------------
# User Data for ECS Instances
# -----------------------------------------------------------

# Join ECS cluster (variable replaced by Launch Template)
echo "ECS_CLUSTER=${ECS_CLUSTER}" >> /etc/ecs/ecs.config
echo "ECS_ENABLE_TASK_IAM_ROLE=true" >> /etc/ecs/ecs.config

# Install & enable CloudWatch Agent (minimal metrics/logs)
dnf install -y amazon-cloudwatch-agent || true
systemctl enable --now amazon-cloudwatch-agent || true
