# -----------------------------------------------------------
# Registry Module: Create ECR Repositories for App Components
# -----------------------------------------------------------

# ECR repo for API container
resource "aws_ecr_repository" "api" {
  name = "${var.name_prefix}-api"
  tags = var.tags
}

# ECR repo for Dashboard container
resource "aws_ecr_repository" "dash" {
  name = "${var.name_prefix}-dash"
  tags = var.tags
}

# ECR repo for Worker container
resource "aws_ecr_repository" "worker" {
  name = "${var.name_prefix}-worker"
  tags = var.tags
}
