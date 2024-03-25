########################################################################################################################
## Auto Scaling Group
########################################################################################################################

resource "aws_autoscaling_group" "auto_scaling_group" {
  name                = "${var.namespace}_ASG_${var.environment}"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  # vpc_zone_identifier = [for i in aws_subnet.private_subnet[*] : i.id] 
  vpc_zone_identifier =  var.private_subnet[*] 
  target_group_arns   = [var.target_group_arn]   
  
  launch_template {
    id      = var.launch_template_id  
    version = var.launch_template_latest_version  
  }
  
}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name               = "CPUUtilizationScalingPolicy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_autoscaling_group.auto_scaling_group.resource_id
  scalable_dimension = "ec2:instance:cpuutilization"
  
  target_tracking_scaling_policy_configuration {
    target_value = 50
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}

resource "aws_autoscaling_policy" "memory_scaling_policy" {
  name               = "MemoryUtilizationScalingPolicy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_autoscaling_group.auto_scaling_group.resource_id
  scalable_dimension = "ec2:instance:memoryutilization"
  
  target_tracking_scaling_policy_configuration {
    target_value = 50
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageMemoryUtilization"
    }
  }
}
