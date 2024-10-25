provider "aws" {
  region = "us-east-1"
}

// vpc 
resource "aws_vpc" "mani_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "mani_vpc"
  }
}

// subnet
resource "aws_subnet" "mani_subnet" {
  vpc_id     = aws_vpc.mani_vpc.id
  cidr_block = var.public_subnet_cidr
  tags = {
    Name = "mani_subnet_pub"
  }
}

// internet gateway
resource "aws_internet_gateway" "mani_igw" {
  vpc_id = aws_vpc.mani_vpc.id
  tags = {
    Name = "mani_igw"
  }
}

// route table
resource "aws_route_table" "mani_rt" {
  vpc_id = aws_vpc.mani_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mani_igw.id
  }
  tags = {
    Name = "mani_rt"
  }
}

// route table association
resource "aws_route_table_association" "mani_rta" {
  subnet_id      = aws_subnet.mani_subnet.id
  route_table_id = aws_route_table.mani_rt.id
}

// security group
resource "aws_security_group" "mani_sg" {
  vpc_id = aws_vpc.mani_vpc.id
  tags = {
    Name = "mani_sg"
  }
}

// security group rule port 22
resource "aws_security_group_rule" "mani_sg_rule" {
    security_group_id = aws_security_group.mani_sg.id
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.myIP,"18.206.107.24/29"]
}

// security group rule port 80

resource "aws_security_group_rule" "mani_sg_rule_80" {
    security_group_id = aws_security_group.mani_sg.id
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}


// ec2 instance

resource "aws_instance" "mani_ec2" {
  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.mani_subnet.id
  security_groups = [aws_security_group.mani_sg.id]
  associate_public_ip_address = true
  key_name = var.key_name
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Deployed via Terraform</h1>" > /var/www/html/index.html
              EOF
  tags = {
    Name = "mani_ec2"
  }
}

// output
output "mani_ec2_ip" {
  value = aws_instance.mani_ec2.public_ip
}