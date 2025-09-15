# -----------------------------------------------------------
# Apps Module: ECS Task Definitions (API, Dashboard, Worker)
# -----------------------------------------------------------

resource "aws_ecs_task_definition" "api" {
  family                   = "${var.name_prefix}-api"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.task_exec_role
  task_role_arn            = var.task_role

  container_definitions = jsonencode([
    {
      name      = "api",
      image     = "REPLACE_WITH_ECR_API:latest",
      essential = true,
      portMappings = [{
        containerPort = var.api_port,
        hostPort      = var.api_port,
        protocol      = "tcp"
      }],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.log_group_api,
          awslogs-region        = var.region,
          awslogs-stream-prefix = "ecs"
        }
      },
      environment = [
        { name = "AWS_REGION", value = var.region }
      ],
      secrets = [
        { name = "JWT_SECRET", valueFrom = var.ssm_jwt_arn }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "dash" {
  family                   = "${var.name_prefix}-dash"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.task_exec_role
  task_role_arn            = var.task_role

  container_definitions = jsonencode([
    {
      name      = "dash",
      image     = "REPLACE_WITH_ECR_DASH:latest",
      essential = true,
      portMappings = [{
        containerPort = var.dash_port,
        hostPort      = var.dash_port,
        protocol      = "tcp"
      }],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.log_group_dash,
          awslogs-region        = var.region,
          awslogs-stream-prefix = "ecs"
        }
      },
      environment = [
        { name = "AWS_REGION", value = var.region }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "worker" {
  family                   = "${var.name_prefix}-worker"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.task_exec_role
  task_role_arn            = var.task_role

  container_definitions = jsonencode([
    {
      name      = "worker",
      image     = "REPLACE_WITH_ECR_WORKER:latest",
      essential = true,
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.log_group_worker,
          awslogs-region        = var.region,
          awslogs-stream-prefix = "ecs"
        }
      },
      environment = [
        { name = "AWS_REGION", value = var.region }
      ]
    }
  ])
}
