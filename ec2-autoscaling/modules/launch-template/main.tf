########################################################################################################################
## Launch Template 
########################################################################################################################

resource "aws_launch_template" "launch_template" {
  name        = "${var.namespace}_Launch_Template_${var.environment}"
  image_id      = var.ami
  instance_type = var.instance_type

  network_interfaces {
    device_index    = 0
    security_groups = [var.asg_sg_id]
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
    Name = "${var.namespace}_Launch_Template_${var.environment}"
    }
  }

 user_data = filebase64("${path.module}./../../user-data/launch-template-user-data.sh")
}