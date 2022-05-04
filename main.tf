/*
  Our main network container
  Belongs to a region (us-east-1 in our case)
*/
resource "aws_vpc" "scuba_syndrome" {
  cidr_block                       = "10.16.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "ScubaSyndrome"
  }
}

# Internet gateway allows traffic from the VPC to public internet
resource "aws_internet_gateway" "ssigw" {
  vpc_id = aws_vpc.scuba_syndrome.id

  tags = {
    Name = "SSIGW"
  }
}

# Setup NAT connectivity
resource "aws_eip" "nat_a" {
  vpc = true
}

resource "aws_eip" "nat_b" {
  vpc = true
}

resource "aws_eip" "nat_c" {
  vpc = true
}

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

  route_table_id = aws_route_table.nat_rt_a.id
  subnet_id = each.value
}

resource "aws_route_table" "nat_rt_a" {
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

  route_table_id = aws_route_table.nat_rt_b.id
  subnet_id = each.value
}

resource "aws_route_table" "nat_rt_b" {
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

  route_table_id = aws_route_table.nat_rt_c.id
  subnet_id = each.value
}

resource "aws_route_table" "nat_rt_c" {
  vpc_id = aws_vpc.scuba_syndrome.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.web_c.id
  }

  tags = {
    Name = "PrivateRTAZC"
  }
}

resource "aws_egress_only_internet_gateway" "eigw" {
  vpc_id = aws_vpc.scuba_syndrome.id
}