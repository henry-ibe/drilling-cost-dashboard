# -----------------------------------------------------------
# Variables for Identity Module (IAM & SSM Parameters)
# -----------------------------------------------------------

variable "region" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "tags" {
  type = map(string)
}

# ARN of the S3 bucket (from storage module)
variable "bucket_arn" {
  type = string
}
