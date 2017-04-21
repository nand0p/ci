FROM centos:7

MAINTAINER Fernando Jose Pando <nando@hex7.com>

RUN yum -y groupinstall 'Development Tools' && \
    yum -y install libffi-devel openssl-devel python-devel java-1.8.0-openjdk which unzip wget epel-release kernel-headers kernel-devel && \
    wget --no-verbose -O /etc/yum.repos.d/virtualbox.repo http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo && \
    wget --no-verbose -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo && \
    rpm -v --import https://jenkins-ci.org/redhat/jenkins-ci.org.key && \
    yum -y install jenkins VirtualBox-5.1 && \
    wget --no-verbose -O /root/terraform.zip https://releases.hashicorp.com/terraform/0.9.3/terraform_0.9.3_linux_amd64.zip && \
    unzip /root/terraform.zip -d /usr/local/bin && \
    wget --no-verbose -O /root/packer.zip https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip && \
    unzip /root/packer.zip -d /usr/local/bin && \
    wget --no-verbose -O /root/install-docker.sh https://get.docker.com/ && \
    bash /root/install-docker.sh && \
    wget --no-verbose -O /root/vagrant.rpm https://releases.hashicorp.com/vagrant/1.9.3/vagrant_1.9.3_x86_64.rpm && \
    rpm -Uvh /root/vagrant.rpm && \
    wget --no-verbose -O /root/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python /root/get-pip.py && \
    pip install awscli virtualenv ansible && \
    usermod -aG vboxusers,docker jenkins && \
    mkdir -m 0755 /nix && chown jenkins /nix && \
    chown -c jenkins /var/lib/jenkins && \
    chsh -s /bin/bash jenkins

USER jenkins

ENV USER jenkins

RUN vagrant box add centos/7 --provider virtualbox && \
    wget -O /tmp/nix-installer.sh https://nixos.org/nix/install && \
    bash /tmp/nix-installer.sh && \
    . /var/lib/jenkins/.nix-profile/etc/profile.d/nix.sh

CMD ["java", "-jar", "/usr/lib/jenkins/jenkins.war"]

