terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  shared_credentials_files = ["/home/svjtosha/.aws/credentials"]
}

module "vpc" {
  source = "./modules/vpc"
  project = var.project
  namespace = var.namespace
  environment = var.environment
}

module "sg" {
  source = "./modules/sg"
  vpc = module.vpc.vpc
  project = var.project
  namespace = var.namespace
  environment = var.environment
}

module "alb" {
  source = "./modules/alb"
  vpc = module.vpc.vpc
  project = var.project
  namespace = var.namespace
  environment = var.environment
  public_subnet = module.vpc.public_subnet
  alb_sg_id = module.sg.alb_sg_id
  container_port = var.container_port
}

module "launch-template" {
  source = "./modules/launch-template"
  namespace = var.namespace
  environment = var.environment
  asg_sg_id = module.sg.asg_sg_id
}

module "asg" {
  source = "./modules/asg"
  namespace = var.namespace
  environment = var.environment
  target_group_arn = module.alb.target_group_arn
  private_subnet = module.vpc.private_subnet
  launch_template_id = module.launch-template.launch_template_id
  launch_template_latest_version = module.launch-template.launch_template_latest_version
}