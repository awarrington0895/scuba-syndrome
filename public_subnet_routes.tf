/*
  This route table allows public internet access to any subnet associated with it.
  This effectively makes the subnet a public subnet.
*/
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.scuba_syndrome.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ssigw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.ssigw.id
  }

  tags = {
    Name = "SSPublicRT"
  }
}

resource "aws_route_table_association" "public_subnets" {
  for_each = {
    "web_a" = aws_subnet.web_a.id,
    "web_b" = aws_subnet.web_b.id,
    "web_c" = aws_subnet.web_c.id
  }

  route_table_id = aws_route_table.public_route_table.id
  subnet_id = each.value
}