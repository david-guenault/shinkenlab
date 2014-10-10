# Shinken Base for building others shinken roles
# 
# VERSION		2.0.3

FROM		centos:centos6
MAINTAINER	David GUENAULT

# prerequisites
RUN			yum clean all
RUN			yum -y update
RUN			yum -y install wget openssh-server
RUN			wget http://mirrors.ircam.fr/pub/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
RUN			yum -y install epel-release-6-8.noarch.rpm redhat-lsb-core
RUN			yum -y install python-pycurl python-pip python-setuptools git vim-enhanced wget	
RUN			echo 'alias pip="/usr/bin/pip-python"' >> $HOME/.bashrc
RUN			source $HOME/.bashrc

# install shinken
RUN			adduser shinken
RUN			git clone https://github.com/naparuba/shinken.git
RUN			cd shinken && git checkout tags/2.0.3
RUN                                cd shinken && python setup.py install

# ssh keys for pack linux ssh
RUN                               mkdir -p /home/shinken/.ssh
RUN                               chown -R shinken:shinken /home/shinken/.ssh
RUN                               ssh-keygen -q -t rsa -f /home/shinken/.ssh/id_rsa -N ""
RUN                               chmod 0600 /home/shinken/.ssh/id_rsa*

# create folders
RUN                               mkdir -p /var/run/shinken /var/log/shinken
RUN                               chown shinken:shinken /var/run/shinken /var/log/shinken
RUN                               chown shinken:shinken /var/run/shinken /var/log/shinken

# set defaults
ADD                                files/shinken /etc/shinken
RUN			chown -R shinken:shinken /etc/shinken

# install modules and packs
RUN                                su - shinken -c "shinken --init"
RUN                                su - shinken -c "shinken install linux-ssh"
RUN                                su - shinken -c "shinken install webui"
RUN                                su - shinken -c "shinken install mod-mongodb"
RUN                                su - shinken -c "shinken install logstore-sqlite"
RUN                                su - shinken -c "shinken install logstore-mongodb"
RUN                                su - shinken -c "shinken install pickle-retention-file-scheduler"

# install supervisor
RUN			pip install supervisor
RUN			mkdir -p /etc/supervisord.d
RUN			mkdir -p /var/log/supervisor
ADD                                files/supervisord.conf /etc/supervisord.conf
ADD 		             files/sshd.conf /etc/supervisord.d/

# launch command
CMD chown -R shinken:shinken /etc/shinken
CMD supervisord -c /etc/supervisord.conf -n

