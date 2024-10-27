# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

# VPC Configuration
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

# Public Subnets Configuration
variable "public_subnets" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
}

# Private Subnets Configuration
variable "private_subnets" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
}

# Availability Zones
variable "availability_zones" {
  description = "List of availability zones to use for the subnets."
  type        = list(string)
}

# Load Balancer Configuration
variable "lb_name" {
  description = "Name for the load balancer."
  type        = string
}

variable "target_group_name" {
  description = "Name for the load balancer target group."
  type        = string
}

variable "target_port" {
  description = "Port for the load balancer target group."
  type        = number
}

variable "listener_port" {
  description = "Listener port for the load balancer."
  type        = number
}

# EC2 Template Configuration
variable "template_name" {
  description = "Name for the EC2 launch template."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances in the ASG."
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair for accessing the EC2 instances."
  type        = string
}

# Auto Scaling Group Configuration
variable "desired_capacity" {
  description = "Desired number of instances in the ASG."
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the ASG."
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the ASG."
  type        = number
}

variable "user_data" {
  description = "User data to run on the EC2 instances."
  type        = string 
}
