provider "aws" {
  region = "us-east-1"
}


data "template_file" "bootstrap" {
  template = file("bootstrap.tpl")
  vars = {
    buildbot_port = var.buildbot_port
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
