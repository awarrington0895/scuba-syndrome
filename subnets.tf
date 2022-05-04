resource "aws_subnet" "web_a" {
  cidr_block                      = "10.16.0.0/20"
  vpc_id                          = aws_vpc.scuba_syndrome.id
  availability_zone               = "us-east-1a"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 00)


  tags = {
    Name = "WebA"
    Type = "Public"
  }
}

resource "aws_subnet" "app_a" {
  cidr_block                      = "10.16.16.0/20"
  vpc_id                          = aws_vpc.scuba_syndrome.id
  availability_zone               = "us-east-1a"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 01)


  tags = {
    Name = "AppA"
    Type = "Private"
  }
}

resource "aws_subnet" "db_a" {
  cidr_block                      = "10.16.32.0/20"
  vpc_id                          = aws_vpc.scuba_syndrome.id
  availability_zone               = "us-east-1a"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 02)


  tags = {
    Name = "DbA"
    Type = "Private"
  }
}

resource "aws_subnet" "web_b" {
  cidr_block                      = "10.16.48.0/20"
  vpc_id                          = aws_vpc.scuba_syndrome.id
  availability_zone               = "us-east-1b"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 03)


  tags = {
    Name = "WebB"
    Type = "Public"
  }
}

resource "aws_subnet" "app_b" {
  cidr_block                      = "10.16.64.0/20"
  vpc_id                          = aws_vpc.scuba_syndrome.id
  availability_zone               = "us-east-1b"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 04)


  tags = {
    Name = "AppB"
    Type = "Private"
  }
}

resource "aws_subnet" "db_b" {
  cidr_block                      = "10.16.80.0/20"
  vpc_id                          = aws_vpc.scuba_syndrome.id
  availability_zone               = "us-east-1b"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 05)


  tags = {
    Name = "DbB"
    Type = "Private"
  }
}

resource "aws_subnet" "web_c" {
  cidr_block                      = "10.16.96.0/20"
  vpc_id                          = aws_vpc.scuba_syndrome.id
  availability_zone               = "us-east-1c"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 06)


  tags = {
    Name = "WebC"
    Type = "Public"
  }
}

resource "aws_subnet" "app_c" {
  cidr_block                      = "10.16.112.0/20"
  vpc_id                          = aws_vpc.scuba_syndrome.id
  availability_zone               = "us-east-1c"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 07)


  tags = {
    Name = "AppC"
    Type = "Private"
  }
}

resource "aws_subnet" "db_c" {
  cidr_block                      = "10.16.128.0/20"
  vpc_id                          = aws_vpc.scuba_syndrome.id
  availability_zone               = "us-east-1c"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 08)


  tags = {
    Name = "DbC"
    Type = "Private"
  }
}
