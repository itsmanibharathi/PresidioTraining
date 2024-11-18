provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Owner       = "Mani"
      terraform   = "true"
    }
  }
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Mani-VPC"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet-1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet-1"
  }
}

resource "aws_subnet" "public_subnet-2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet-2"
  }
}


# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "mani_igw"
  }
}

# Create Route Table
# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.my_vpc.id
#   tags = {
#     Name = "mani_public_route_table"
#   }
# }


resource "aws_default_route_table" "public_route_table" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id
  tags = {
    Name = "mani_public_route_table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


