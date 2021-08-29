provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "hex7" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.tag_name
  }
}


resource "aws_internet_gateway" "hex7" {
  vpc_id = aws_vpc.hex7.id

  tags = {
    Name = var.tag_name
  }
}


resource "aws_subnet" "hex7" {
  vpc_id     = aws_vpc.hex7.id
  cidr_block = var.subnet1_cidr
  tags = {
    Name = var.tag_name
  }
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "hex7_secondary" {
  vpc_id     = aws_vpc.hex7.id
  cidr_block = var.subnet2_cidr
  tags = {
    Name = var.tag_name
  }
  availability_zone = "us-east-1a"
}


resource "aws_route_table" "hex7" {
  vpc_id = aws_vpc.hex7.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hex7.id
  }
  tags = {
    Name = var.tag_name
  }
}


resource "aws_route_table_association" "hex7" {
  subnet_id      = aws_subnet.hex7.id
  route_table_id = aws_route_table.hex7.id
}


resource "aws_route_table_association" "hex7_secondary" {
  subnet_id      = aws_subnet.hex7_secondary.id
  route_table_id = aws_route_table.hex7.id
}


resource "aws_eip" "hex7" {
  instance = aws_instance.hex7.id
  vpc      = true
  tags = {
    Name = var.tag_name
  }
}


resource "aws_key_pair" "hex7" {
  key_name   = var.tag_name
  public_key = var.ssh_pub_key
  tags = {
    Name = var.tag_name
  }
}


resource "aws_instance" "hex7" {
  ami                         = data.aws_ami.latest_amazon.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.hex7.id
  vpc_security_group_ids      = [aws_security_group.hex7.id]
  subnet_id                   = aws_subnet.hex7.id
  associate_public_ip_address = true
  source_dest_check           = false
  iam_instance_profile        = aws_iam_instance_profile.hex7.name
  user_data                   = data.template_file.bootstrap.rendered

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.tag_name
  }

  root_block_device {
    volume_size = 100
    volume_type = "standard"
    tags = {
      Name = var.tag_name
    }
  }
}


resource "aws_iam_instance_profile" "hex7" {
  name = "hex7"
  role = aws_iam_role.hex7.name
}


resource "aws_iam_role" "hex7" {
  name = "hex7"
  tags = {
    Name = var.tag_name
  }

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}


resource "aws_iam_role_policy" "hex7" {
  name = "hex7"
  role = aws_iam_role.hex7.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*",
        "ssm:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_security_group" "hex7" {
  name   = var.tag_name
  vpc_id = aws_vpc.hex7.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.trusted_location]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.tag_name
  }
}


output "hex7_eip" {
  value = aws_eip.hex7.public_ip
}
