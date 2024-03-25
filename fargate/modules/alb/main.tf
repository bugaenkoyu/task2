########################################################################################################################
## Application Load Balancer in public subnets with HTTP default listener 
########################################################################################################################

resource "aws_alb" "alb" {
  name            = "${var.namespace}-ALB-${var.environment}"
  security_groups = [var.alb_sg]
  subnets         = var.public_subnet[*]

  tags = {
    Project = var.project
  }
}

########################################################################################################################
## Target Group for our service
########################################################################################################################

resource "aws_alb_target_group" "service_target_group" {
  name                 = "${var.namespace}-TargetGroup-${var.environment}"
  port                 = var.container_port
  protocol             = "HTTP"
  vpc_id               = var.vpc.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Project = var.project
  }

  depends_on = [aws_alb.alb]
}
# Default HTTPS listener 

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.service_target_group.arn
  }
    tags = {
    Project = var.project
  }
}