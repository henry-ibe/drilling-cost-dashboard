# -----------------------------------------------------------
# Variables for Foundation Module (VPC Lookups & Security Groups)
# -----------------------------------------------------------

variable "region"      { type = string }
variable "name_prefix" { type = string }
variable "tags"        { type = map(string) }

variable "api_port"  { type = number }
variable "dash_port" { type = number }

# e.g., "0.0.0.0/0" for open dev access
variable "allowed_cidr" { type = string }
