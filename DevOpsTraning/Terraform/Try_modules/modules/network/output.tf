output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "ec2-sg_id" {
  value = aws_security_group.ec2-sg.id
}

output "lb-sg_id" {
  value = aws_security_group.lb-sg.id
}

output "bastion-sg_id" {
  value = aws_security_group.bastion-sg.id
}
