resource "aws_subnet" "private_subnet" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = data.aws_subnet.public_metadata.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = local.target_public_subnet_id
}

resource "aws_route" "private_internet_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}
