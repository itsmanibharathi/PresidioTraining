resource "aws_launch_template" "main" {
  name          = var.template_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(var.user_data)
  
  update_default_version = true 
  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = var.subnet_id
  }
}