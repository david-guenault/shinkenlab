# mongodb server
#
# VERSION	2.4.6.5

FROM		centos:centos6
MAINTAINER	David GUENAULT

# install prerequisites
RUN			yum clean all 
RUN			yum -y update 
ADD			files/10gen.repo /etc/yum.repos.d/10gen.repo
ADD			files/epel-release-6-8.noarch.rpm /tmp/
RUN			rpm -Uvh /tmp/epel-release-6-8.noarch.rpm
RUN			yum clean all
RUN			yum -y install python-pip
RUN			rm -f /tmp/epel*

# install mongodb
RUN			yum install -y mongodb-org
RUN			mkdir -p /data/db

# install supervisor
RUN			pip install supervisor && mkdir -p /etc/supervisord.d && mkdir -p /var/log/supervisor
ADD 		files/supervisord.conf /etc/supervisord.conf
ADD 		files/mongodb.conf /etc/supervisord.d/mongodb.conf

EXPOSE		27017

CMD 		supervisord -c /etc/supervisord.conf -n