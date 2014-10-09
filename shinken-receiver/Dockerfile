# Shinken receiver with only receiver role
# 
# VERSION		1.4

FROM		dguenault/shinken-base:1.4
MAINTAINER	David GUENAULT

ADD 		files/shinken-receiver.conf /etc/supervisord.d/
RUN			sed -i 's/AVAIL_MODULES=.*/AVAIL_MODULES="receiver"/g' /etc/init.d/shinken

EXPOSE 7773
