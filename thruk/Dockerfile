# Thruk
# 
# VERSION		

FROM		centos:centos6
MAINTAINER	David GUENAULT

# prerequisites
RUN		yum clean all
RUN 	yum -y update
RUN		rpm -Uvh http://mirrors.ircam.fr/pub/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
RUN		rpm -Uvh "https://labs.consol.de/repo/stable/rhel6/i386/labs-consol-stable.rhel6.noarch.rpm"
RUN		yum -y install redhat-lsb-core python-pip

# install thruk
RUN		yum -y install thruk

# install supervisor
RUN			pip install supervisor 
RUN			mkdir -p /etc/supervisord.d 
RUN			mkdir -p /var/log/supervisor
ADD 		files/supervisord.conf /etc/supervisord.conf
ADD 		files/thruk.conf /etc/supervisord.d/thruk.conf

EXPOSE	80
CMD 		supervisord -c /etc/supervisord.conf -n