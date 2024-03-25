output "vpc" {
  value = module.vpc.vpc.id
}

output "public_subnet" {
  value = module.vpc.public_subnet
}

output "private_subnet" {
  value = module.vpc.private_subnet
}

output "asg_sg_id" {
  value = module.sg.asg_sg_id
}

output "alb_sg_id" {
  value = module.sg.alb_sg_id
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "launch_template_id" {
  value = module.launch-template.launch_template_id
}

output "launch_template_latest_version" {
  value = module.launch-template.launch_template_latest_version
}
