data "aws_ami" "latest_amazon" {
  most_recent = true
  owners      = ["137112412989"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

variable "tag_name" {
  type    = string
  default = "hex7-2021-09-12"
}

variable "vpc_cidr" {
  type    = string
  default = "192.168.108.0/23"
}

variable "subnet1_cidr" {
  type    = string
  default = "192.168.108.0/24"
}

variable "subnet2_cidr" {
  type    = string
  default = "192.168.109.0/24"
}

variable "instance_type" {
  type    = string
  default = "t3a.micro"
}

variable "ssh_pub_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwH1rWuQJXZXXgyWmJp6ripDLSyTGteNkvsn4AO/Bqo+TWSX1bxmDH4uk94D2/YOsRQiPs+dDHuJuBIqZnZicnOhbQFzi4EegV1S9Xw4ZWzJu9JT6dcI3ThOlQ2LVeEYajo+A1eoTdr5Hkfs79w+9FvLjYHgbuhvcsR5n9jFHynM0JPjcnDR7wNnDdqFoQqUFHG6nyJ3MotUBQGWuH/iDGOxcefHCbazdYTj4nFtbVtkAX8qRDz0ajlXGIhCVnV5/K7U1ZpXOlRIc8Ylt/v3DQsyvedUIyPrGLvzYx1tJXTbPWK3gXHAYRvDsydrCGfwiVCPK29Vfewy8fBaO/tdJB"
}

variable "trusted_location" {
  type = string
}

variable "route53_hex7_com_zone" {
  type    = string
  default = "Z2YZQHSWZVS6YV"
}

variable "route53_hex7_net_zone" {
  type    = string
  default = "Z2JRDJ4NHF5DME"
}

variable "route53_damnswank_com_zone" {
  type    = string
  default = "Z8A9TY9K3WJ2R"
}

variable "route53_nomadic_red_zone" {
  type    = string
  default = "Z00565411O4LUODSIUATX"
}

variable "elb_health_check" {
  type    = string
  default = "HTTPS:443/nginx-health"
}

variable "load_balancer_enable" {
  type    = bool
  default = true
}

variable "buildbot_port" {
  type    = string
  default = "8010"
}
