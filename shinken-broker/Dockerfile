# Shinken broker with only broker role
# 
# VERSION		1.4

FROM		dguenault/shinken-base:1.4
MAINTAINER	David GUENAULT

ADD 		files/shinken-broker.conf /etc/supervisord.d/
RUN			sed -i 's/AVAIL_MODULES=.*/AVAIL_MODULES="broker"/g' /etc/init.d/shinken

EXPOSE 7772
EXPOSE 50000
EXPOSE 7767
