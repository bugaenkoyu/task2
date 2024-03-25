variable "namespace" {}

variable "environment" {}

variable "asg_sg_id" {}

variable "ami" {
  description = "ami id"  ///
  type        = string
  default     = "ami-0843a4d6dc2130849"
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}
