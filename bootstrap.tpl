#!/bin/bash -ex

echo swap
fallocate -l 10G /swapfile
chmod 600 /swapfile
mkswap /swapfile
echo "/swapfile    none    swap    sw    0    0" | tee -a /etc/fstab
cat /etc/fstab
swapon -a
swapon --show

echo disable
systemctl stop amazon-ssm-agent
systemctl disable amazon-ssm-agent
systemctl stop rpcbind
systemctl disable rpcbind
systemctl stop postfix
systemctl disable postfix
systemctl stop gssproxy
systemctl disable gssproxy
systemctl stop atd
systemctl disable atd
systemctl stop crond
systemctl disable crond
systemctl stop acpid
systemctl disable acpid

echo packages
yum install -y docker git htop python3-Cython python3-devel python3-libs python3-pip python3-setuptools

echo docker
usermod -aG docker ec2-user
systemctl enable docker
systemctl start docker

echo buildbot
cd /root
git clone https://github.com/nand0p/ci.git
cd ci/hex7
bash docker_run_master.sh
bash docker_run_worker.sh

echo nginx
amazon-linux-extras install nginx1.12 -y
wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/nand0p/ci/master/nginx.conf
wget -O /usr/share/nginx/html/50x.html https://raw.githubusercontent.com/nand0p/ci/master/50x.html
wget -O /usr/share/nginx/html/404.html https://raw.githubusercontent.com/nand0p/ci/master/404.html

chmod -c 750 /var/log/nginx

echo get secrets
mkdir -pv /etc/nginx/ssl
aws ssm get-parameter --region us-east-1 --name HEX7_KEY --with-decryption --query Parameter.Value --output text | tee /etc/nginx/ssl/hex7.com.key
aws ssm get-parameter --region us-east-1 --name HEX7_CRT --with-decryption --query Parameter.Value --output text | tee /etc/nginx/ssl/hex7.com.crt

systemctl start nginx
systemctl enable nginx
 
touch /root/.cloudinit.success
