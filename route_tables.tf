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

resource "aws_route_table_association" "web_a" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.web_a.id
}

resource "aws_route_table_association" "web_b" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.web_b.id
}

resource "aws_route_table_association" "web_c" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.web_c.id
}
