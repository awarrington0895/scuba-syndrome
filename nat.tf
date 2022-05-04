# Elastic IPs must be allocated for each NAT gateway
resource "aws_eip" "nat_a" {
  vpc = true
}

resource "aws_eip" "nat_b" {
  vpc = true
}

resource "aws_eip" "nat_c" {
  vpc = true
}

/*
  A NAT gateway is a way to enable resources in a private subnet to connect
  to the public internet.  Each NAT must be put in a public subnet because
  it needs a public IP address.
*/
resource "aws_nat_gateway" "web_a" {
  connectivity_type = "public"
  allocation_id = aws_eip.nat_a.id
  subnet_id = aws_subnet.web_a.id

  tags = {
    Name = "NATGWWEBA"
  }

  depends_on = [aws_internet_gateway.ssigw]
}

resource "aws_nat_gateway" "web_b" {
  connectivity_type = "public"
  allocation_id = aws_eip.nat_b.id
  subnet_id = aws_subnet.web_b.id

  tags = {
    Name = "NATGWWEBB"
  }

  depends_on = [aws_internet_gateway.ssigw]
}

resource "aws_nat_gateway" "web_c" {
  connectivity_type = "public"
  allocation_id = aws_eip.nat_c.id
  subnet_id = aws_subnet.web_c.id

  tags = {
    Name = "NATGWWEBC"
  }


  depends_on = [aws_internet_gateway.ssigw]
}

resource "aws_route_table_association" "nat_rt_assoc_a" {
  for_each = {
    "app_a" = aws_subnet.app_a.id,
    "db_a" = aws_subnet.db_a.id
  }

  route_table_id = aws_route_table.pvt_az_a.id
  subnet_id = each.value
}

/*
  A route table must exist to give a path to the NAT gateway
*/
resource "aws_route_table" "pvt_az_a" {
  vpc_id = aws_vpc.scuba_syndrome.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.web_a.id
  }

  tags = {
    Name = "PrivateRTAZA"
  }
}

resource "aws_route_table_association" "nat_rt_assoc_b" {
  for_each = {
    "app_b" = aws_subnet.app_b.id,
    "db_b" = aws_subnet.db_b.id
  }

  route_table_id = aws_route_table.pvt_az_b.id
  subnet_id = each.value
}

resource "aws_route_table" "pvt_az_b" {
  vpc_id = aws_vpc.scuba_syndrome.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.web_b.id
  }

  route {
    ipv6_cidr_block = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.eigw.id
  }

  tags = {
    Name = "PrivateRTAZB"
  }
}

resource "aws_route_table_association" "nat_rt_assoc_c" {
  for_each = {
    "app_c" = aws_subnet.app_c.id,
    "db_c" = aws_subnet.db_c.id
  }

  route_table_id = aws_route_table.pvt_az_c.id
  subnet_id = each.value
}

resource "aws_route_table" "pvt_az_c" {
  vpc_id = aws_vpc.scuba_syndrome.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.web_c.id
  }

  tags = {
    Name = "PrivateRTAZC"
  }
}

# This allows outbound internet access for ipv6 resources
# Does not permit inbound initiated traffic
resource "aws_egress_only_internet_gateway" "eigw" {
  vpc_id = aws_vpc.scuba_syndrome.id
}
