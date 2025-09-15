# -----------------------------------------------------------
# Terraform Outputs for Drilling Cost Dashboard Infrastructure
# -----------------------------------------------------------

output "bucket_name"     { value = module.storage.bucket_name }
output "ecr_api"         { value = module.registry.ecr_api }
output "ecr_dash"        { value = module.registry.ecr_dash }
output "ecr_worker"      { value = module.registry.ecr_worker }
output "ecs_cluster_name"{ value = module.compute.ecs_cluster_name }
