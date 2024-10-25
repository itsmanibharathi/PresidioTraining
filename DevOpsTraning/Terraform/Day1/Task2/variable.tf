variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/26"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.0.0/28"
}

variable "myIP" {
  description = "My IP address"
  type        = string
  default     = "14.194.142.66/32"
}

variable "key_name" {
  description = "The name of the EC2 Key Pair"
  type        = string
}