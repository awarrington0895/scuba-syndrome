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

# VPC Endpoint
resource "aws_vpc_endpoint" "s3" {
  service_name    = "com.amazonaws.us-east-1.s3"
  vpc_id          = aws_vpc.scuba_syndrome.id
  route_table_ids = [
    aws_route_table.pvt_az_a.id,
    aws_route_table.pvt_az_b.id,
    aws_route_table.pvt_az_c.id
  ]

  tags = {
    Name = "EndpointS3"
  }
}

resource "aws_vpc_endpoint" "sns" {
  service_name = "com.amazonaws.us-east-1.sns"
  vpc_id       = aws_vpc.scuba_syndrome.id
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.app_a.id,
    aws_subnet.web_b.id,
    aws_subnet.web_c.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "EndpointSNS"
  }
}