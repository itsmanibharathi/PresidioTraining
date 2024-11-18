resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Owner = "mani"
    Name = "main-vpc"
  }
}

variable "vpc_cidr" {}