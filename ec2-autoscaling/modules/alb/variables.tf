variable "vpc" {}

variable "public_subnet" {}

variable "alb_sg_id" {}

variable "container_port" {}

variable "project" {}

variable "namespace" {}

variable "environment" {}

variable "healthcheck_endpoint" {
  description = "Endpoint for ALB healthcheck"
  type        = string
  default     = "/"
}

variable "healthcheck_matcher" {
  description = "HTTP status code matcher for healthcheck"
  type        = string
  default     = "200"
}

