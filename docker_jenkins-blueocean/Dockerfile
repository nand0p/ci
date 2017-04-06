FROM jenkinsci/blueocean

MAINTAINER Fernando Jose Pando <nando@hex7.com>

USER root
RUN mkdir -m 0755 /nix && \
    chown jenkins /nix && \
    addgroup nixbld

USER jenkins
ENV USER jenkins
RUN curl https://nixos.org/nix/install | sh && \
    . /var/jenkins_home/.nix-profile/etc/profile.d/nix.sh && \
    nix-env -i terraform
    #. /var/jenkins_home/.nix-profile/etc/profile.d/nix.sh

#    apt-get -y install netcat wget libmysqlclient-dev libpq-dev gcc python-dev libldap2-dev libsasl2-dev make g++ time \
#        libqt5core5a libqt5gui5 libqt5opengl5 libqt5printsupport5 libqt5widgets5 libqt5x11extras5 libsdl1.2debian libvpx1 libxmu6 && \
    # module-init-tools linux-headers-4.9.0-0 
#    wget --no-verbose -O /tmp/virtualbox-5.1.deb http://download.virtualbox.org/virtualbox/5.1.18/virtualbox-5.1_5.1.18-114002~Debian~jessie_amd64.deb && \
#    wget --no-verbose -O /tmp/install-docker.sh https://get.docker.com/ && \
#    bash /tmp/install-docker.sh && \
#    wget --no-verbose -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
#    python /tmp/get-pip.py && \
#    pip install awscli virtualenv && \
#    wget --no-verbose -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.9.2/terraform_0.9.2_linux_amd64.zip && \
#    wget --no-verbose -O /tmp/vagrant.deb https://releases.hashicorp.com/vagrant/1.9.3/vagrant_1.9.3_x86_64.deb && \
#    unzip /tmp/terraform.zip -d /usr/local/bin && \
#    dpkg -i /tmp/vagrant.deb && \
#    usermod -aG vboxusers,docker jenkins && \


#RUN vagrant box add centos/7 --provider virtualbox && \
#    bash /tmp/nix-installer.sh && \
#    wget -O /tmp/nix-installer.sh https://nixos.org/nix/install && \
