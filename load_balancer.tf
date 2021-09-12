resource "aws_elb" "hex7" {
  count = var.load_balancer_enable ? 1 : 0

  name            = "hex7-frontend-elb"
  subnets         = [aws_subnet.hex7.id, aws_subnet.hex7_secondary[0].id]
  security_groups = [aws_security_group.hex7_elb[0].id]

  access_logs {
    bucket        = aws_s3_bucket.elb_logs.bucket
    interval      = 60
  }

  listener {
    instance_port      = 443
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.hex7.id
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = var.elb_health_check
    interval            = 30
  }

  instances                   = [aws_instance.hex7.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.tag_name}-frontend"
    Cert = aws_acm_certificate.hex7.id
    
  }
}

data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "elb_logs" {
  bucket = "hex7-elb-logs"
  acl    = "private"

  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::hex7-elb-logs/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY
}
