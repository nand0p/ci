FROM centos:7

MAINTAINER Fernando Jose Pando <nando@hex7.com>

RUN yum -y groupinstall 'Development Tools' && \
    yum -y install libffi-devel openssl-devel python-devel which unzip wget epel-release kernel-headers kernel-devel

ARG JAVA=1.8.0
ARG TERRAFORM=0.9.4
ARG VIRTUALBOX=5.1
ARG PACKER=1.0.0
ARG VAGRANT=1.9.3

RUN wget --no-verbose -O install-docker.sh https://get.docker.com/ && \
    bash install-docker.sh

RUN wget --no-verbose https://releases.hashicorp.com/terraform/${TERRAFORM}/terraform_${TERRAFORM}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM}_linux_amd64.zip -d /usr/local/bin

RUN wget --no-verbose https://releases.hashicorp.com/packer/${PACKER}/packer_${PACKER}_linux_amd64.zip && \
    unzip packer_${PACKER}_linux_amd64.zip -d /usr/local/bin

RUN wget --no-verbose https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install awscli virtualenv ansible

RUN wget --no-verbose -O /etc/yum.repos.d/virtualbox.repo http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo && \
    yum -y install VirtualBox-${VIRTUALBOX} && \
    wget --no-verbose https://releases.hashicorp.com/vagrant/${VAGRANT}/vagrant_${VAGRANT}_x86_64.rpm && \
    rpm -Uvh vagrant_${VAGRANT}_x86_64.rpm

RUN yum -y install java-${JAVA}-openjdk && \
    wget --no-verbose -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo && \
    rpm -v --import https://jenkins-ci.org/redhat/jenkins-ci.org.key && \
    yum -y install jenkins && \
    chown -c jenkins /var/lib/jenkins && \
    usermod -aG vboxusers,docker jenkins && \
    chsh -s /bin/bash jenkins && \
    mkdir -m 0755 /nix && chown jenkins /nix

USER jenkins

ENV USER jenkins

RUN vagrant box add centos/7 --provider virtualbox && \
    wget -O /tmp/nix-installer.sh https://nixos.org/nix/install && \
    bash /tmp/nix-installer.sh && \
    . /var/lib/jenkins/.nix-profile/etc/profile.d/nix.sh

CMD ["java", "-jar", "/usr/lib/jenkins/jenkins.war"]

