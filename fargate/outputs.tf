output "vpc" {
  value = module.vpc.vpc.id
}

output "public_subnet" {
  value = module.vpc.public_subnet
}

output "private_subnet" {
  value = module.vpc.private_subnet
}

output "ecs_sg" {
  value = module.sg.ecs_sg
}

output "alb_sg" {
  value = module.sg.alb_sg
}

output "alb" {
  value = module.alb.alb
}

output "ecs_target_group" {
  value = module.alb.ecs_target_group
}

output "ecs_task_execution_role" {
  value = module.iam.ecs_task_execution_role
}

output "aws_ecs_cluster_name" {
  value = module.ecs.aws_ecs_cluster_name
}

output "aws_ecs_service_name" {
  value = module.ecs.aws_ecs_service_name
}
