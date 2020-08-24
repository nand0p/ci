#!/bin/bash -ex

echo swap
fallocate -l 2G /swapfile
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
yum install -y docker git htop python3-Cython python3-devel python3-libs python3-pip python3-setuptools mariadb-server

echo mysql
systemctl start mariadb

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
chmod -c 750 /var/log/nginx
systemctl start nginx
systemctl enable nginx

touch /root/.cloudinit.success
