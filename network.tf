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
  count = var.load_balancer_enable ? 1 : 0

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
  count = var.load_balancer_enable ? 1 : 0

  subnet_id      = aws_subnet.hex7_secondary[0].id
  route_table_id = aws_route_table.hex7.id
}


resource "aws_eip" "hex7" {
  instance = aws_instance.hex7.id
  vpc      = true
  tags = {
    Name = var.tag_name
  }
}

output "hex7_eip" {
  value = aws_eip.hex7.public_ip
}
