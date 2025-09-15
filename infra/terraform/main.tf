# -----------------------------------------------------------
# Main Terraform Configuration for Drilling Cost Dashboard
# -----------------------------------------------------------

terraform {
  # (We'll add provider/backend in providers.tf)
}

# Identity module
module "identity" {
  source       = "./modules/identity"
  region       = var.region
  name_prefix  = local.name_prefix
  tags         = local.tags
  bucket_arn   = module.storage.bucket_arn
}

# Compute module
module "compute" {
  source            = "./modules/compute"
  region            = var.region
  name_prefix       = local.name_prefix
  tags              = local.tags
  instance_type     = var.instance_type
  iam_instance_prof = module.identity.ec2_instance_profile
  sg_id             = module.foundation.ecs_host_sg_id
  subnets           = module.foundation.subnet_ids
}

# Logging module
module "logging" {
  source      = "./modules/logging"
  name_prefix = local.name_prefix
}

# Apps (task definitions)
module "apps" {
  source           = "./modules/apps"
  region           = var.region
  name_prefix      = local.name_prefix
  task_exec_role   = module.identity.task_exec_role
  task_role        = module.identity.task_role
  log_group_api    = module.logging.log_group_api
  log_group_dash   = module.logging.log_group_dash
  log_group_worker = module.logging.log_group_worker
  api_port         = var.api_port
  dash_port        = var.dash_port
  ssm_jwt_arn      = module.identity.ssm_jwt_arn
  ssm_bucket_name  = module.identity.ssm_bucket_name
}

# Services (ECS services)
module "services" {
  source       = "./modules/services"
  cluster_name = module.compute.cluster_name
  api_td_arn   = module.apps.api_td_arn
  dash_td_arn  = module.apps.dash_td_arn
}

# Scheduling (EventBridge -> worker)
module "scheduling" {
  source        = "./modules/scheduling"
  region        = var.region
  name_prefix   = local.name_prefix
  cluster_arn   = module.compute.cluster_arn
  worker_td_arn = module.apps.worker_td_arn
  schedule_expr = var.worker_rate
}
