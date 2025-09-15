# -----------------------------------------------------------
# Storage Module: S3 Data Lake Bucket
# -----------------------------------------------------------

resource "aws_s3_bucket" "data" {
  bucket = "${var.name_prefix}-${var.bucket_suffix}"

  tags = var.tags
}

# Enable versioning
resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "data" {
  bucket                  = aws_s3_bucket.data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
