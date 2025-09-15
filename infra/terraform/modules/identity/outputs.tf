# -----------------------------------------------------------
# Outputs for Identity Module
# -----------------------------------------------------------

output "task_exec_role" {
  value = aws_iam_role.task_exec_role.arn
}

output "task_role" {
  value = aws_iam_role.task_role.arn
}

output "ec2_instance_profile" {
  value = aws_iam_instance_profile.ec2_instance_profile.name
}

# ARN of the JWT secret parameter
output "ssm_jwt_arn" {
  value = aws_ssm_parameter.jwt_secret.arn
}

# Name of the bucket_name SSM parameter (handy to fetch by name)
output "ssm_bucket_name" {
  value = aws_ssm_parameter.bucket_name.name
}
