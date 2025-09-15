# -----------------------------------------------------------
# Foundation: default VPC lookups + ECS host Security Group
# -----------------------------------------------------------

# Default VPC (assumes your account still has a default VPC)
data "aws_vpc" "default" {
  default = true
}

# All subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security Group for ECS host / services (API + Dashboard)
resource "aws_security_group" "ecs_host" {
  name   = "${var.name_prefix}-ecs-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = var.api_port
    to_port     = var.api_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
    description = "API ingress"
  }

  ingress {
    from_port   = var.dash_port
    to_port     = var.dash_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
    description = "Dashboard ingress"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all egress"
  }

  tags = var.tags
}
