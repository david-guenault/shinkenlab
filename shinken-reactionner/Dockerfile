# Shinken reactionner with only reactionner role
# 
# VERSION		1.4

FROM		dguenault/shinken-base:1.4
MAINTAINER	David GUENAULT

ADD 		files/shinken-reactionner.conf /etc/supervisord.d/
RUN			sed -i 's/AVAIL_MODULES=.*/AVAIL_MODULES="reactionner"/g' /etc/init.d/shinken

EXPOSE 7769
