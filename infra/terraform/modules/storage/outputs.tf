# -----------------------------------------------------------
# Outputs for Storage Module
# -----------------------------------------------------------

# Bucket name
output "bucket_name" {
  value = aws_s3_bucket.data.bucket
}

# Bucket ARN
output "bucket_arn" {
  value = aws_s3_bucket.data.arn
}
