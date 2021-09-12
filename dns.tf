resource "aws_route53_record" "hex7_com_root_elb" {
  count = var.load_balancer_enable ? 1 : 0

  zone_id = var.route53_hex7_com_zone
  name    = "hex7.com."
  type    = "A"
  alias  {
    zone_id = aws_elb.hex7[0].zone_id
    name = aws_elb.hex7[0].dns_name
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "hex7_com_root_eip" {
  count = var.load_balancer_enable ? 0 : 1

  zone_id = var.route53_hex7_com_zone
  name    = "hex7.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "hex7_net_root_elb" {
  count = var.load_balancer_enable ? 1 : 0

  zone_id = var.route53_hex7_net_zone
  name    = "hex7.net."
  type    = "A"
  alias  {
    zone_id = aws_elb.hex7[0].zone_id
    name = aws_elb.hex7[0].dns_name
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "hex7_net_root_eip" {
  count = var.load_balancer_enable ? 0 : 1

  zone_id = var.route53_hex7_net_zone
  name    = "hex7.net."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "hex7_damnswank_com_root" {
  zone_id = var.route53_damnswank_com_zone
  name    = "damnswank.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "hex7_nomadic_red_root_elb" {
  count = var.load_balancer_enable ? 1 : 0

  zone_id = var.route53_nomadic_red_zone
  name    = "nomadic.red."
  type    = "A"
  alias  {
    zone_id = aws_elb.hex7[0].zone_id
    name = aws_elb.hex7[0].dns_name
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "hex7_nomadic_red_root_eip" {
  count = var.load_balancer_enable ? 0 : 1

  zone_id = var.route53_nomadic_red_zone
  name    = "nomadic.red."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "hex7_ssh" {
  zone_id = var.route53_hex7_com_zone
  name    = "ssh.hex7.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "hex7_buildbot" {
  zone_id = var.route53_hex7_com_zone
  name    = "buildbot.hex7.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "nomadic_dev" {
  zone_id = var.route53_nomadic_red_zone
  name    = "dev.nomadic.red."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "hex7_dev" {
  zone_id = var.route53_hex7_com_zone
  name    = "dev.hex7.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}

resource "aws_route53_record" "reart" {
  zone_id = var.route53_hex7_com_zone
  name    = "reart.hex7.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}

resource "aws_route53_record" "reimage" {
  zone_id = var.route53_hex7_com_zone
  name    = "reimage.hex7.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}

resource "aws_route53_record" "hubble" {
  zone_id = var.route53_hex7_com_zone
  name    = "hubble.hex7.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}

resource "aws_route53_record" "hex7_com_catchall_elb" {
  count = var.load_balancer_enable ? 1 : 0

  zone_id = var.route53_hex7_com_zone
  name    = "*.hex7.com."
  type    = "CNAME"
  ttl     = "300"
  records = [aws_elb.hex7[0].dns_name]
}

resource "aws_route53_record" "hex7_com_catchall_eip" {
  count = var.load_balancer_enable ? 0 : 1
  
  zone_id = var.route53_hex7_com_zone
  name    = "*.hex7.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "hex7_net_catchall_elb" {
  count = var.load_balancer_enable ? 1 : 0

  zone_id = var.route53_hex7_net_zone
  name    = "*.hex7.net."
  type    = "CNAME"
  ttl     = "300"
  records = [aws_elb.hex7[0].dns_name]
}

resource "aws_route53_record" "hex7_net_catchall_eip" {
  count = var.load_balancer_enable ? 0 : 1

  zone_id = var.route53_hex7_net_zone
  name    = "*.hex7.net."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "hex7_damnswank_com_catchall" {
  zone_id = var.route53_damnswank_com_zone
  name    = "*.damnswank.com."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}


resource "aws_route53_record" "hex7_nomadic_red_catchall_elb" {
  count = var.load_balancer_enable ? 1 : 0

  zone_id = var.route53_nomadic_red_zone
  name    = "*.nomadic.red."
  type    = "CNAME"
  ttl     = "300"
  records = [aws_elb.hex7[0].dns_name]
}


resource "aws_route53_record" "hex7_nomadic_red_catchall_eip" {
  count = var.load_balancer_enable ? 0 : 1

  zone_id = var.route53_nomadic_red_zone
  name    = "*.nomadic.red."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.hex7.public_ip]
}
