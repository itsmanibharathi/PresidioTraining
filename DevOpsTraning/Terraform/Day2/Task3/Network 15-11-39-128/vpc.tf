resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = merge(local.common_tags, {
    Name = "main-vpc"
  })
}

variable "vpc_cidr" {}
locals {
  common_tags = {}
}
