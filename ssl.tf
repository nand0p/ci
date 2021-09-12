resource "aws_acm_certificate" "hex7" {
  domain_name               = "hex7.com"
  validation_method         = "DNS"
  subject_alternative_names = [
    "*.hex7.com",
    "hex7.net",
    "*.hex7.net",
    "nomadic.red",
    "*.nomadic.red"
  ]
  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "hex7_com_verify" {
  for_each = {
    for dvo in aws_acm_certificate.hex7.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.route53_hex7_com_zone
}


resource "aws_route53_record" "hex7_net_verify" {
  for_each = {
    for dvo in aws_acm_certificate.hex7.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.route53_hex7_net_zone
}


resource "aws_route53_record" "nomadic_red_verify" {
  for_each = {
    for dvo in aws_acm_certificate.hex7.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.route53_nomadic_red_zone
}
