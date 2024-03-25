########################################################################################################################
## SG for ECS fargate
########################################################################################################################

resource "aws_security_group" "ecs_sg" {
  name        = "${var.namespace}_ECS_SecurityGroup_${var.environment}"
  description = "Security group for ECS task running on Fargate"
  vpc_id      = var.vpc.id

  ingress {
    description     = "Allow ingress traffic from ALB on HTTP only"
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.namespace}_ECS_SecurityGroup_${var.environment}"
    Project = var.project
  }
}

########################################################################################################################
# SG for ALB
########################################################################################################################

resource "aws_security_group" "alb_sg" {
  name        = "${var.namespace}_ALB_SecurityGroup_${var.environment}"
  description = "Security group for ALB"
  vpc_id      = var.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80 //80
    to_port     = 80 //80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.namespace}_ALB_SecurityGroup_${var.environment}"
    Project = var.project
  }
}