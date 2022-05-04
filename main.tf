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
