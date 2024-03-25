variable "project" {}

variable "namespace" {}

variable "environment" {}

variable "region" {}

variable "private_subnet" {}

variable "ecs_task_execution_role" {}

variable "ecs_target_group" {}

variable "ecs_sg" {}

variable "ecs_task_desired_count" {
  description = "How many ECS tasks should run in parallel"
  default     = 2
  type        = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "How many percent of a service must be running to still execute a safe deployment"
  default     = 50
  type        = number
}

variable "ecs_task_deployment_maximum_percent" {
  description = "How many additional tasks are allowed to run (in percent) while a deployment is executed"
  default     = 100
  type        = number
}

variable "target_capacity" {
  description = "Amount of resources of container instances that should be used for task placement in %"
  default     = 100
  type        = number
}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 3000
}

variable "cpu_units" {
  description = "Amount of CPU units for a single ECS task"
  default     = 256
  type        = number
}

variable "memory" {
  description = "Amount of memory in MB for a single ECS task"
  default     = 512
  type        = number
}

variable "service_name" {
  description = "A Docker image-compatible name for the service"
  default     = "nodejs-demoapp"
  type        = string
}

variable "retention_in_days" {
  description = "Retention period for Cloudwatch logs"
  default     = 7
  type        = number
}

variable "repository_url" {
  description = "A repository url"
  default     = "ghcr.io/benc-uk/nodejs-demoapp"
  type        = string
}

variable "image_tag" {
  description = "Image tag"
  default     = "latest"
  type        = string
}