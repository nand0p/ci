provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "hex7" {
    cidr_block = var.cidr
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
    vpc_id = aws_vpc.hex7.id
    cidr_block = var.cidr
    tags = {
        Name = var.tag_name
    }
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
    subnet_id = aws_subnet.hex7.id
    route_table_id = aws_route_table.hex7.id
}

resource "aws_eip" "hex7" {
    instance = aws_instance.hex7.id
    vpc = true
    tags = {
        Name = var.tag_name
    }
}

resource "aws_key_pair" "hex7" {
    key_name = var.tag_name
    public_key = var.ssh_pub_key
    tags = {
        Name = var.tag_name
    }
}

resource "aws_instance" "hex7" {
    ami = data.aws_ami.latest_amazon.id
    instance_type = var.instance_type
    key_name = aws_key_pair.hex7.id
    vpc_security_group_ids = [ aws_security_group.hex7.id ]
    subnet_id = aws_subnet.hex7.id
    associate_public_ip_address = true
    source_dest_check = false
    tags = {
        Name = var.tag_name
    }
    user_data = data.template_file.user_data.rendered
}

resource "aws_security_group" "hex7" {
    name   = var.tag_name
    vpc_id = aws_vpc.hex7.id
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ var.trusted_location ]
    }
    ingress {
        from_port   = 80 
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port  = 0 
        to_port    = 0
        protocol   = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    tags = {
        Name = var.tag_name
    }
}

resource "aws_route53_record" "hex7_com_root" {
  zone_id = var.route53_hex7_com_zone
  name    = "hex7.com."
  type    = "A"
  ttl     = "300"
  records = [ aws_eip.hex7.public_ip ]
}

resource "aws_route53_record" "hex7_com_catchall" {
  zone_id = var.route53_hex7_com_zone
  name    = "*.hex7.com."
  type    = "A"
  ttl     = "300"
  records = [ aws_eip.hex7.public_ip ]
}

resource "aws_route53_record" "hex7_net_root" {
  zone_id = var.route53_hex7_net_zone
  name    = "hex7.net."
  type    = "A"
  ttl     = "300"
  records = [ aws_eip.hex7.public_ip ]
}

resource "aws_route53_record" "hex7_net_catchall" {
  zone_id = var.route53_hex7_net_zone
  name    = "*.hex7.net."
  type    = "A"
  ttl     = "300"
  records = [ aws_eip.hex7.public_ip ]
}

resource "aws_route53_record" "hex7_damnswank_com_root" {
  zone_id = var.route53_damnswank_com_zone
  name    = "damnswank.com."
  type    = "A"
  ttl     = "300"
  records = [ aws_eip.hex7.public_ip ]
}

resource "aws_route53_record" "hex7_damnswank_com_catchall" {
  zone_id = var.route53_damnswank_com_zone
  name    = "*.damnswank.com."
  type    = "A"
  ttl     = "300"
  records = [ aws_eip.hex7.public_ip ]
}

output "hex7_eip" {
  value = aws_eip.hex7.public_ip
}
