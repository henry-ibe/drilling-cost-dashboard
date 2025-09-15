# -----------------------------------------------------------
# Variables for Services Module (ECS Services)
# -----------------------------------------------------------

# ECS cluster name where services will run
variable "cluster_name" {
  type = string
}

# Task definition ARNs for API and Dashboard
variable "api_td_arn" {
  type = string
}

variable "dash_td_arn" {
  type = string
}

# Optional: desired task counts (defaults Free Tier–friendly)
variable "api_desired_count" {
  type    = number
  default = 1
}

variable "dash_desired_count" {
  type    = number
  default = 1
}
