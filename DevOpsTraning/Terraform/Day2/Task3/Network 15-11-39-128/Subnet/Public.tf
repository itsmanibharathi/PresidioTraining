resource "aws_subnet" "public_subnet" {
  count = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags,
  {
    Name = "public-subnet-${count.index}"
  })
}

locals {
  common_tags ={}
}