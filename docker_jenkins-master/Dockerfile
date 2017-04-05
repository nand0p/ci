FROM jenkins

MAINTAINER Fernando Jose Pando <nando@hex7.com>

USER root

RUN echo "deb http://download.virtualbox.org/virtualbox/debian jessie contrib" | \
        tee -a /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get -y --force-yes install \
        libmysqlclient-dev libpq-dev gcc python-dev libldap2-dev libsasl2-dev make g++ time virtualbox-5.1 docker.io python3-docker && \
    curl https://bootstrap.pypa.io/get-pip.py | python && \
    pip install awscli virtualenv && \
    wget https://releases.hashicorp.com/terraform/0.9.2/terraform_0.9.2_linux_amd64.zip && \
    wget https://releases.hashicorp.com/vagrant/1.9.3/vagrant_1.9.3_x86_64.deb && \
    unzip terraform_0.9.2_linux_amd64.zip -d /usr/local/bin && \
    dpkg -i vagrant_1.9.3_x86_64.deb && \
    groupadd docker && \
    usermod -aG vboxusers,docker jenkins

USER jenkins

RUN vagrant box add centos/7 --provider virtualbox
