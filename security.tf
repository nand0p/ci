resource "aws_key_pair" "hex7" {
  key_name   = var.tag_name
  public_key = var.ssh_pub_key
  tags = {
    Name = var.tag_name
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


resource "aws_security_group" "hex7_elb" {
  count = var.load_balancer_enable ? 1 : 0

  name   = "{var.tag_name}_elb"
  vpc_id = aws_vpc.hex7.id
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
