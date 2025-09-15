# -----------------------------------------------------------
# Identity: IAM Roles, Instance Profile, SSM Parameters
# -----------------------------------------------------------

locals {
  bucket_name = regex("^arn:aws:s3:::([^:]+)$", var.bucket_arn)
}

# ---- ECS Task Execution Role (pull images, write logs, read params) ----
data "aws_iam_policy_document" "ecs_task_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals { type = "Service" identifiers = ["ecs-tasks.amazonaws.com"] }
  }
}

resource "aws_iam_role" "task_exec_role" {
  name               = "${var.name_prefix}-ecs-task-exec"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
  tags               = var.tags
}

# Managed policy for pulling from ECR and sending logs
resource "aws_iam_role_policy_attachment" "task_exec_managed" {
  role       = aws_iam_role.task_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Minimal inline to read SSM parameters (plain String)
data "aws_iam_policy_document" "task_exec_ssm_read" {
  statement {
    actions   = ["ssm:GetParameter", "ssm:GetParameters"]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "task_exec_ssm_read" {
  name   = "${var.name_prefix}-ecs-exec-ssm-read"
  policy = data.aws_iam_policy_document.task_exec_ssm_read.json
}
resource "aws_iam_role_policy_attachment" "task_exec_ssm_read_attach" {
  role       = aws_iam_role.task_exec_role.name
  policy_arn = aws_iam_policy.task_exec_ssm_read.arn
}

# ---- ECS Task Role (your app's AWS permissions; keep minimal) ----
resource "aws_iam_role" "task_role" {
  name               = "${var.name_prefix}-ecs-task"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
  tags               = var.tags
}

# ---- EC2 Instance Profile for ECS host/agents ----
data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals { type = "Service" identifiers = ["ec2.amazonaws.com"] }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.name_prefix}-ec2"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
  tags               = var.tags
}

# SSM access for EC2
resource "aws_iam_role_policy_attachment" "ec2_ssm_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# (Optional but helpful) CloudWatch agent
resource "aws_iam_role_policy_attachment" "ec2_cw_agent" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Allow EC2 to put objects into the project bucket (e.g., logs/artifacts)
data "aws_iam_policy_document" "ec2_bucket_put" {
  statement {
    actions   = ["s3:PutObject", "s3:PutObjectAcl"]
    resources = ["arn:aws:s3:::${local.bucket_name}/*"]
  }
}
resource "aws_iam_policy" "ec2_bucket_put" {
  name   = "${var.name_prefix}-ec2-bucket-put"
  policy = data.aws_iam_policy_document.ec2_bucket_put.json
}
resource "aws_iam_role_policy_attachment" "ec2_bucket_put_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_bucket_put.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.name_prefix}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# ---- SSM Parameters used by tasks/apps ----
resource "aws_ssm_parameter" "jwt_secret" {
  name  = "/${var.name_prefix}/jwt_secret"
  type  = "String"       # change to SecureString if you want KMS encryption
  value = "CHANGE_ME"    # update via console or TF var later
  tags  = var.tags
}

resource "aws_ssm_parameter" "bucket_name" {
  name  = "/${var.name_prefix}/bucket_name"
  type  = "String"
  value = local.bucket_name
  tags  = var.tags
}
