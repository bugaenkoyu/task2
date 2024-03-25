########################################################################################################################
## Creates an ECS Cluster
########################################################################################################################

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.namespace}_ECSCluster_${var.environment}"

  tags = {
    Name     = "${var.namespace}_ECSCluster_${var.environment}"
    Project = var.project
  }
}

########################################################################################################################
## Create log group for our service
########################################################################################################################

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/${lower(var.namespace)}/ecs/${var.service_name}"
  retention_in_days = var.retention_in_days

  tags = {
    Project = var.project
  }
}

########################################################################################################################
## Creates ECS Task Definition
########################################################################################################################

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.namespace}_ECS_TaskDefinition_${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.ecs_task_execution_role 
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name         = var.service_name
      image        = "${var.repository_url}:${var.image_tag}"
      cpu          = var.cpu_units
      memory       = var.memory
      essential    = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.service_name}-log-stream-${var.environment}"
        }
      }
    }
  ])

  tags = {
    Project = var.project
  }
}

########################################################################################################################
## Creates ECS Service
########################################################################################################################

resource "aws_ecs_service" "service" {
  name                               = "${var.namespace}_ECS_Service_${var.environment}"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.task_definition.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = var.ecs_target_group
    container_name   = var.service_name
    container_port   = var.container_port
  }

  network_configuration {
    security_groups  = [var.ecs_sg]
    subnets          = var.private_subnet[*]
    assign_public_ip = false
  }

  tags = {
    Project = var.project
  }
}