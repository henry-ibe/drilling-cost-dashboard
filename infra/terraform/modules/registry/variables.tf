# -----------------------------------------------------------
# Variables for Registry Module (Amazon ECR Repositories)
# -----------------------------------------------------------

# Prefix to use when naming ECR repositories
variable "name_prefix" {
  type = string
}

# Common tags to apply to all ECR repositories
variable "tags" {
  type = map(string)
}
