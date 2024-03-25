variable "region" {
  default = "eu-west-1"
  type = string
  description = "The region where I want to deploy the infrastructure in"
}

variable "namespace" {
  description = "Namespace for resource names"
  default     = "task2"
  type        = string
}

variable "project" {
  description = "Project name for tags"
  default     = "ecs-fargate"
  type        = string
}

variable "environment" {
  description = "Environment for deployment (like dev or staging)"
  default     = "ecs"
  type        = string
}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 3000
}