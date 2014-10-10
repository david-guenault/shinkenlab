# Shinken poller with only poller role
# 
# VERSION		2.0.3

FROM		dguenault/shinken-base:2.0.3
MAINTAINER	David GUENAULT

RUN	             yum -y install nagios-plugins-all
ADD 		files/shinken-poller.conf /etc/supervisord.d/

EXPOSE 7771

