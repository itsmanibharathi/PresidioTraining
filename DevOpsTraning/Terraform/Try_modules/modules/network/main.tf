# VPC
resource "aws_vpc" "main" {
  cidr_block              = var.vpc_cidr
  enable_dns_hostnames    = true
  enable_dns_support      = true
  tags = {
    Name = "${var.Project}-vpc"
  }
}

# Internet Gateway for Public Subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.Project}-igw"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name = "${var.Project}-public-${count.index}"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.Project}-private-${count.index}"
  }
}

# Default Route Table (Public Route Table) - Reuse the default route table for public subnets
resource "aws_default_route_table" "public" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.Project}-public-rt"
  }
}

# Association of Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_default_route_table.public.id
}

# NAT Gateway in one of the public subnets
resource "aws_eip" "nat" {
  associate_with_private_ip = null
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "${var.Project}-nat"
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.Project}-private-rt"
  }
}

# Association of Private Subnets with Private Route Table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Security Group ec2 allow 80 amd 22
resource "aws_security_group" "ec2-sg" {
  vpc_id = aws_vpc.main.id
  name   = "${var.Project}-ec2-sg"
  description = "Allow 80 and 22"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.lb-sg.id]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.bastion-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [aws_security_group.lb-sg, aws_security_group.bastion-sg]
  tags = {
    Name = "${var.Project}-ec2-sg"
  }
}

// lb security group
resource "aws_security_group" "lb-sg" {
  vpc_id = aws_vpc.main.id
  name   = "${var.Project}-lb-sg"
  description = "Allow 80"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// bastion security group
resource "aws_security_group" "bastion-sg" {
  vpc_id = aws_vpc.main.id
  name   = "${var.Project}-bastion-sg"
  description = "Allow 22"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["18.206.107.24/29"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}