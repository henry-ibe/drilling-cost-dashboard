# -----------------------------------------------------------
# Scheduling: EventBridge Rule → ECS RunTask (Worker)
# -----------------------------------------------------------

# EventBridge schedule rule (e.g., "rate(5 minutes)")
resource "aws_cloudwatch_event_rule" "worker_schedule" {
  name                = "${var.name_prefix}-worker-schedule"
  schedule_expression = var.schedule_expr
  description         = "Triggers the ${var.name_prefix}-worker task on a schedule"
}

# IAM role that EventBridge assumes to call ecs:RunTask
data "aws_iam_policy_document" "events_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "events_to_ecs" {
  name               = "${var.name_prefix}-events-to-ecs"
  assume_role_policy = data.aws_iam_policy_document.events_assume.json
}

# Policy: allow RunTask on the worker TD and PassRole (broad for demo; tighten later)
data "aws_iam_policy_document" "events_run_task" {
  statement {
    actions   = ["ecs:RunTask"]
    resources = [var.worker_td_arn]
    condition {
      test     = "ArnEquals"
      variable = "ecs:cluster"
      values   = [var.cluster_arn]
    }
  }

  # NOTE: This is permissive for simplicity. In production, restrict to your task & execution role ARNs.
  statement {
    actions   = ["iam:PassRole"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "events_run_task" {
  name   = "${var.name_prefix}-events-run-task"
  policy = data.aws_iam_policy_document.events_run_task.json
}

resource "aws_iam_role_policy_attachment" "events_run_task_attach" {
  role       = aws_iam_role.events_to_ecs.name
  policy_arn = aws_iam_policy.events_run_task.arn
}

# Target: run the ECS task on schedule (EC2/bridge => no networkConfiguration block)
resource "aws_cloudwatch_event_target" "worker_target" {
  rule      = aws_cloudwatch_event_rule.worker_schedule.name
  target_id = "ecs-run-worker"
  arn       = var.cluster_arn
  role_arn  = aws_iam_role.events_to_ecs.arn

  ecs_target {
    launch_type         = "EC2"
    task_definition_arn = var.worker_td_arn
    task_count          = 1
    # You can add "group" or "tags" here if desired
  }
}
