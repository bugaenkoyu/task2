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
  alb_sg = module.sg.alb_sg
  container_port = var.container_port
}

module "iam" {
  source = "./modules/iam"
  project = var.project
  namespace = var.namespace
  environment = var.environment
}

module "ecs" {
  source = "./modules/ecs"
  project = var.project
  region = var.region
  namespace = var.namespace
  environment = var.environment
  private_subnet = module.vpc.private_subnet
  ecs_sg = module.sg.ecs_sg
  ecs_target_group = module.alb.ecs_target_group
  ecs_task_execution_role = module.iam.ecs_task_execution_role
}

module "auto-scaling" {
  source = "./modules/auto-scaling"
  namespace = var.namespace
  environment = var.environment
  aws_ecs_cluster_name = module.ecs.aws_ecs_cluster_name
  aws_ecs_service_name = module.ecs.aws_ecs_service_name
}