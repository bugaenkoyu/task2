output "alb_arn" {
  value = aws_alb.alb.arn
}

output "target_group_arn" {
  value = aws_alb_target_group.service_target_group.arn
}