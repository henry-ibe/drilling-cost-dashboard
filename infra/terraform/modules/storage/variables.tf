# -----------------------------------------------------------
# Variables for Storage Module (S3 Data Lake)
# -----------------------------------------------------------

# Prefix used when naming the S3 bucket
variable "name_prefix" {
  type = string
}

# Unique suffix to ensure the bucket name is globally unique
variable "bucket_suffix" {
  type = string
}

# Common tags to apply to the bucket
variable "tags" {
  type = map(string)
}
