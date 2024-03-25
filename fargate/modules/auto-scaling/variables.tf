variable "namespace" {}

variable "environment" {}

variable "aws_ecs_cluster_name" {}

variable "aws_ecs_service_name" {}

variable "ecs_task_min_count" {
  description = "How many ECS tasks should minimally run in parallel"
  default     = 2
  type        = number
}

variable "ecs_task_max_count" {
  description = "How many ECS tasks should maximally run in parallel"
  default     = 4
  type        = number
}

variable "cpu_target_tracking_desired_value" {
  description = "Target tracking for CPU usage in %"
  default     = 50
  type        = number
}

variable "memory_target_tracking_desired_value" {
  description = "Target tracking for memory usage in %"
  default     = 50
  type        = number
}