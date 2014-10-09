# Shinken scheduler with only scheduler role
# 
# VERSION		1.4

FROM		dguenault/shinken-base:1.4
MAINTAINER	David GUENAULT

ADD 		files/shinken-scheduler.conf /etc/supervisord.d/
RUN			sed -i 's/AVAIL_MODULES=.*/AVAIL_MODULES="scheduler"/g' /etc/init.d/shinken

EXPOSE 7768
