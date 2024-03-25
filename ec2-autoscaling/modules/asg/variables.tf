variable "namespace" {}

variable "environment" {}

variable "target_group_arn" {}

variable "private_subnet" {}

variable "launch_template_id" {}

variable "launch_template_latest_version" {}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "The desired number of EC2 Instances in the ASG"
  type        = number
  default     = 2
}