resource "aws_subnet" "web_a" {
  cidr_block              = "10.16.0.0/20"
  vpc_id                  = aws_vpc.scuba_syndrome.id
  availability_zone       = "us-east-1a"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 0)
  map_public_ip_on_launch = true



  tags = {
    Name = "WebA"
    Type = "Public"
  }
}

resource "aws_subnet" "app_a" {
  cidr_block        = "10.16.16.0/20"
  vpc_id            = aws_vpc.scuba_syndrome.id
  availability_zone = "us-east-1a"
  ipv6_cidr_block   = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 1)


  tags = {
    Name = "AppA"
    Type = "Private"
  }
}

resource "aws_subnet" "db_a" {
  cidr_block        = "10.16.32.0/20"
  vpc_id            = aws_vpc.scuba_syndrome.id
  availability_zone = "us-east-1a"
  ipv6_cidr_block   = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 2)


  tags = {
    Name = "DbA"
    Type = "Private"
  }
}

resource "aws_subnet" "web_b" {
  cidr_block              = "10.16.48.0/20"
  vpc_id                  = aws_vpc.scuba_syndrome.id
  availability_zone       = "us-east-1b"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 3)
  map_public_ip_on_launch = true


  tags = {
    Name = "WebB"
    Type = "Public"
  }
}

resource "aws_subnet" "app_b" {
  cidr_block        = "10.16.64.0/20"
  vpc_id            = aws_vpc.scuba_syndrome.id
  availability_zone = "us-east-1b"
  ipv6_cidr_block   = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 4)


  tags = {
    Name = "AppB"
    Type = "Private"
  }
}

resource "aws_subnet" "db_b" {
  cidr_block        = "10.16.80.0/20"
  vpc_id            = aws_vpc.scuba_syndrome.id
  availability_zone = "us-east-1b"
  ipv6_cidr_block   = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 5)


  tags = {
    Name = "DbB"
    Type = "Private"
  }
}

resource "aws_subnet" "web_c" {
  cidr_block              = "10.16.96.0/20"
  vpc_id                  = aws_vpc.scuba_syndrome.id
  availability_zone       = "us-east-1c"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 6)
  map_public_ip_on_launch = true


  tags = {
    Name = "WebC"
    Type = "Public"
  }
}

resource "aws_subnet" "app_c" {
  cidr_block        = "10.16.112.0/20"
  vpc_id            = aws_vpc.scuba_syndrome.id
  availability_zone = "us-east-1c"
  ipv6_cidr_block   = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 7)


  tags = {
    Name = "AppC"
    Type = "Private"
  }
}

resource "aws_subnet" "db_c" {
  cidr_block        = "10.16.128.0/20"
  vpc_id            = aws_vpc.scuba_syndrome.id
  availability_zone = "us-east-1c"
  ipv6_cidr_block   = cidrsubnet(aws_vpc.scuba_syndrome.ipv6_cidr_block, 8, 8)


  tags = {
    Name = "DbC"
    Type = "Private"
  }
}
