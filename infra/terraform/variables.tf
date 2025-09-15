# -----------------------------------------------------------
# Terraform Variables for Drilling Cost Dashboard Infrastructure
# -----------------------------------------------------------

variable "region"       { type = string  default = "us-east-1" }
variable "project_name" { type = string  default = "drill-cost" }
variable "owner"        { type = string  default = "henry" }
variable "env"          { type = string  default = "dev" }

# Unique suffix for S3 bucket (must be globally unique), e.g., "hibe123"
variable "bucket_suffix" { type = string }

# Dev-open; tighten later
variable "allowed_cidr" { type = string  default = "0.0.0.0/0" }

variable "instance_type" { type = string default = "t3.micro" }
variable "api_port"       { type = number default = 8001 }
variable "dash_port"      { type = number default = 8501 }

# CloudWatch schedule expression for worker
variable "worker_rate"   { type = string default = "rate(5 minutes)" }
