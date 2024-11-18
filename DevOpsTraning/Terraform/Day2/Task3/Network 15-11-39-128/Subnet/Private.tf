resource "aws_subnet" "private_subnet" {
  count = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.${count.index + 2}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(local.common_tags,{
    Name = "private-subnet-${count.index}"
  })
}

locals {
  common_tags = {}
}
