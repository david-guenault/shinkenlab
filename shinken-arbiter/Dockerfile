# Shinken arbiter 
# 
# VERSION		1.4

FROM		dguenault/shinken-base:1.4
MAINTAINER	David GUENAULT

ADD 		files/shinken-arbiter.conf /etc/supervisord.d/
RUN			sed -i 's/AVAIL_MODULES=.*/AVAIL_MODULES="arbiter"/g' /etc/init.d/shinken

EXPOSE 7770