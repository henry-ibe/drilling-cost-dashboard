# -----------------------------------------------------------
# Compute: ECS Cluster, Launch Template, Auto Scaling Group
# -----------------------------------------------------------

# ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = "${var.name_prefix}-ecs"
  tags = var.tags
}

# Latest ECS-optimized Amazon Linux 2023 AMI (pulled via SSM)
data "aws_ssm_parameter" "ecs_al2023_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

# Render user data (inject cluster name)
locals {
  rendered_user_data = templatefile("${path.module}/userdata_ecs.sh", {
    ECS_CLUSTER = aws_ecs_cluster.this.name
  })
}

# Launch Template for ECS hosts
resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "${var.name_prefix}-ecs-"
  image_id      = data.aws_ssm_parameter.ecs_al2023_ami.value
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.iam_instance_prof
  }

  network_interfaces {
    security_groups = [var.sg_id]
  }

  user_data = base64encode(local.rendered_user_data)

  tag_specifications {
    resource_type = "instance"
    tags          = var.tags
  }

  tag_specifications {
    resource_type = "volume"
    tags          = var.tags
  }

  tags = var.tags
}

# Auto Scaling Group to host ECS tasks
resource "aws_autoscaling_group" "ecs_asg" {
  name                      = "${var.name_prefix}-ecs-asg"
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 1
  vpc_zone_identifier       = var.subnets
  health_check_type         = "EC2"
  health_check_grace_period = 90

  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  # Propagate tags to instances
  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# Make sure the ASG exists after the LT and Cluster
resource "aws_autoscaling_attachment" "ecs_asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
  alb_target_group_arn   = null
}

# Outputs (referenced by root module)
output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}
