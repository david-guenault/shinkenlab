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
RUN			yum -y install python-pycurl python-pip python-setuptools git vim-enhanced wget python-pyro	
RUN			echo 'alias pip="/usr/bin/pip-python"' >> $HOME/.bashrc
RUN			source $HOME/.bashrc

# install shinken
RUN			adduser shinken
RUN			git clone https://github.com/naparuba/shinken.git
RUN			cd shinken && git checkout tags/2.0.3
RUN			cp -a ../shinken /usr/local
RUN			chown -R shinken:shinken /usr/local/shinken
RUN			cp -a /usr/local/shinken/bin/init.d/shinken* /etc/init.d/
RUN			chmod +x /etc/init.d/shinken*

# set defaults
RUN			cp /usr/local/shinken/bin/default/shinken.in /etc/default/shinken
RUN			sed -i 's/\$ETC\$/\/etc\/shinken/g' /etc/default/shinken
RUN			sed -i 's/\$VAR\$/\/usr\/local\/shinken\/var/g' /etc/default/shinken
RUN			sed -i 's/\$RUN\$/\/usr\/local\/shinken\/var/g' /etc/default/shinken
RUN			sed -i 's/\$LOG\$/\/usr\/local\/shinken\/var/g' /etc/default/shinken
RUN			sed -i 's/\$SCRIPTS_BIN\$/\/usr\/local\/shinken\/bin/g' /etc/default/shinken
RUN			mkdir -p /etc/shinken
RUN			chown shinken:shinken /etc/shinken

# install supervisor
RUN			pip install supervisor
RUN			mkdir -p /etc/supervisord.d
RUN			mkdir -p /var/log/supervisor
ADD 		files/supervisord.conf /etc/supervisord.conf

# launch command
CMD supervisord -c /etc/supervisord.conf -n

