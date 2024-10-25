provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Owner = "mani"
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Owner = "mani"
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.${count.index + 2}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Owner = "mani"
    Name = "private-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Owner = "mani"
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_route_assoc" {
  count          = 2
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.main_vpc.id

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

  tags = {
    Owner = "mani"
    Name = "alb-sg"
  }
}

resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner = "mani"
    Name = "ec2-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner = "mani"
    Name = "rds-sg"
  }
}

resource "aws_launch_template" "apache_lt" {
  name_prefix   = "apache-lt-"
  
  image_id      = var.ami_id
  instance_type = "t2.micro"

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              
EOF
)

  network_interfaces {
    security_groups = [aws_security_group.ec2_sg.id]
  }
}

output "launch_template_id" {
  value = aws_launch_template.apache_lt.id
}

resource "aws_autoscaling_group" "apache_asg" {
  vpc_zone_identifier         = aws_subnet.public_subnet.*.id
  max_size                    = 2
  min_size                    = 1
  desired_capacity            = 1
  launch_template {
    id      = aws_launch_template.apache_lt.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.apache_tg.arn]
}

resource "aws_lb" "apache_lb" {
  name               = "apache-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnet.*.id

  tags = {
    Owner = "mani"
    Name = "apache-lb"
  }
}

output "lb_dns" {
  value = aws_lb.apache_lb.dns_name
}

resource "aws_lb_target_group" "apache_tg" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id
}

resource "aws_lb_listener" "apache_listener" {
  load_balancer_arn = aws_lb.apache_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache_tg.arn
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  username             = "admin"
  password             = "password"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.main.name
  port                 = 3306
  skip_final_snapshot    = true

  tags = {
    Owner = "mani"
    Name = "mysql-db"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = aws_subnet.private_subnet.*.id

  tags = {
    Owner = "mani"
    Name = "main-db-subnet-group"
  }
}