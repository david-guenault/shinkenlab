# Shinken poller with only poller role
# 
# VERSION		1.4

FROM		dguenault/shinken-base:1.4
MAINTAINER	David GUENAULT

RUN			yum -y install nagios-plugins-all
ADD 		files/shinken-poller.conf /etc/supervisord.d/
RUN			sed -i 's/AVAIL_MODULES=.*/AVAIL_MODULES="poller"/g' /etc/init.d/shinken

EXPOSE 7771

