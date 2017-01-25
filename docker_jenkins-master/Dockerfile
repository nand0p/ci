FROM jenkins

MAINTAINER Fernando Jose Pando <nando@hex7.com>

USER root

RUN echo "deb http://download.virtualbox.org/virtualbox/debian jessie contrib" | \
    tee -a /etc/apt/sources.list

RUN apt-get -y update && apt-get -y --force-yes install \
    libmysqlclient-dev \
    libpq-dev \
    gcc \
    python-dev \
    libldap2-dev \
    libsasl2-dev \
    make \
    g++ \
    time \
    virtualbox-5.0 && \
    apt-get -y upgrade

RUN curl https://bootstrap.pypa.io/get-pip.py | python && \
    pip install awscli virtualenv
RUN wget https://releases.hashicorp.com/terraform/0.8.4/terraform_0.8.4_linux_amd64.zip && \
    wget https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb && \
    unzip terraform_0.8.4_linux_amd64.zip -d /usr/local/bin && \
    dpkg -i vagrant_1.9.1_x86_64.deb

USER jenkins

RUN vagrant box add centos/7 --provider virtualbox
