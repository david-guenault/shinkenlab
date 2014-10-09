shinkenlab
==========

Easy creation of shinken infrastructure labs with docker

What do you need ?
==================

First install docker 

    sudo apt-get install docker
  
Then install nsenter

    sudo docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
  
Finally install fig

    sudo apt-get install curl

    curl -L https://github.com/docker/fig/releases/download/0.5.2/linux > /usr/local/bin/fig
  
    chmod +x /usr/local/bin/fig


Build the containers
====================

    ./build.sh ALL

Run the infrastructure
======================

    fig -f simple-shinken-lab.yml up -d

Find the ip adresses
====================

    ./allip.sh

    /shinkenlab_arbiter_1 172.17.2.114
    /shinkenlab_broker_1 172.17.2.112
    /shinkenlab_poller_1 172.17.2.110
    /shinkenlab_reactionner_1 172.17.2.108
    /shinkenlab_receiver_1 172.17.2.106
    /shinkenlab_scheduler_1 172.17.2.104
    /shinkenlab_mongo_1 172.17.2.102
    /shinkenlab_scheduler2_1 

    the local address for the webui is the broker address. You can now access the webui with the following url : http://172.17.2.112:7767

access the container shell
=====================

    sudo ./go.sh shinkenlab_broker
