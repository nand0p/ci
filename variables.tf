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
  default = "hex7-2020-05-20"
}

variable "cidr" {
  type    = string
  default = "192.168.107.0/24"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
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

locals {
  userdata = <<EOF
#!/bin/bash
touch /root/.cloudinit
yum install -y docker git htop python3-Cython python3-devel python3-libs python3-pip python3-setuptools
amazon-linux-extras install nginx1.12 -y
usermod -aG docker ec2-user
systemctl enable docker
systemctl start docker
cd /root
git clone https://github.com/nand0p/ci.git
cd ci/hex7
bash docker_run_master.sh
bash docker_run_worker.sh
cd /etc/nginx
https://raw.githubusercontent.com/nand0p/ci/master/nginx.conf
systemctl start nginx
systemctl enable nginx
EOF
}
