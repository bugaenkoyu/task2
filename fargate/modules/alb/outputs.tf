output "alb" {
  value = aws_alb.alb.arn
}

output "ecs_target_group" {
  value = aws_alb_target_group.service_target_group.arn
}