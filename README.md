shinkenlab
==========

Easy creation of shinken infrastructure labs with docker

What do you need ?
==================

First install docker 

  ```sudo apt-get install docker```
  
Then install nsenter

  ```sudo docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter```
  
Finally install fig

  ```curl -L https://github.com/docker/fig/releases/download/0.5.2/linux > /usr/local/bin/fig```
  
  ```chmod +x /usr/local/bin/fig```


Build the containers
====================

```./build.sh ALL```

Run the infrastructure
======================

```fig -f simple-shinken-lab.yml up -d```

Find the ip adresses
====================

```./allip.sh```

