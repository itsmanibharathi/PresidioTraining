

resource "aws_autoscaling_group" "main" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.private_subnets
  target_group_arns   = [var.target_group_arn]

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
}
