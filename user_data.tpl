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

cat <<EOF | tee /etc/nginx/nginx.conf
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  hex7.com;
        root         /usr/share/nginx/html;
        location / {
            proxy_pass http://localhost:8000;
        }
        error_page 404 /404.html;
            location = /40x.html {
        }
        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

    server {
        listen       80;
        listen       [::]:80;
        server_name  damnswank.com www.damnswank.com;
        root         /usr/share/nginx/html;
        location / {
            proxy_pass http://localhost:8002;
        }
        error_page 404 /404.html;
            location = /40x.html {
        }
        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

    server {
        listen       80;
        listen       [::]:80;
        server_name  www.covid.hex7.com covid.hex7.com www.covid19.hex7.com covid19.hex7.com;
        root         /usr/share/nginx/html;
        location / {
            proxy_pass http://localhost:5000;
        }
        error_page 404 /404.html;
            location = /40x.html {
        }
        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

}
EOF

systemctl start nginx
systemctl enable nginx
