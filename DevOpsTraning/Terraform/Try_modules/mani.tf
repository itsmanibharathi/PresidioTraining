provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
      CreateBy    = "Terraform"
    }
  }
}

module "network" {
  source             = "./modules/network"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  Project            = var.Project
}

# module "load_balancer" {
#   source            = "./modules/load_balancer"
#   lb_name           = var.lb_name
#   vpc_id            = module.network.vpc_id
#   public_subnets    = module.network.public_subnet_ids
#   security_groups   = [module.network.http_sg_id]
#   target_group_name = var.target_group_name
#   target_port       = var.target_port
#   listener_port     = var.listener_port
# }

# module "ec2_template" {
#   source        = "./modules/ec2_template"
#   template_name = var.template_name
#   ami_id        = var.ami_id
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   subnet_id     = module.network.private_subnet_ids[0]
#   user_data     = var.user_data
# }

# module "auto_scaling_group" {
#   source             = "./modules/auto_scaling_group"
#   desired_capacity   = var.desired_capacity
#   max_size           = var.max_size
#   min_size           = var.min_size
#   private_subnets    = module.network.private_subnet_ids
#   target_group_arn   = module.load_balancer.target_group_arn
#   launch_template_id = module.ec2_template.launch_template_id
# }
