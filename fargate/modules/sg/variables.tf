variable "vpc" {}

variable "project" {}

variable "namespace" {}

variable "environment" {}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 3000
}

