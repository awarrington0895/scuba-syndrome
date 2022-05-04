# AMI and instance for our Bastion Host
data "aws_ami" "aws_linux_ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "kp" {
  public_key = tls_private_key.pk.public_key_openssh
  key_name = "myKey"

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}

# Security group will grant SSH access to the EC2 instance
resource "aws_security_group" "bastion_host" {
  name = "BastionHost"
  description = "BastionHost"
  vpc_id = aws_vpc.scuba_syndrome.id

  ingress {
    from_port = 22
    protocol  = "TCP"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "bastion_host" {
  instance_type = "t2.micro"
  ami = data.aws_ami.aws_linux_ami.id
  subnet_id = aws_subnet.web_b.id
  key_name = aws_key_pair.kp.key_name
  security_groups = [aws_security_group.bastion_host.id]

  tags = {
    Name = "BastionHost"
  }
}
