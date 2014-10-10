#!/bin/bash
BASE=$(readlink -f $(dirname $0))

echo "stopping all containers"

docker stop $(docker ps -qa) 

echo "Cleanup containers"

docker rm $(docker ps -aq) 

echo "Cleanup images"

docker rmi $(docker images -a | grep "shinken" | awk '{print $3}')
docker rmi $(docker images -a | grep "mongo" | awk '{print $3}')
docker rmi $(docker images -a | grep "thruk" | awk '{print $3}')
docker rmi $(docker images -a | grep "<none>" | awk '{print $3}')

echo "cleanup files"

bases="shinken-base shinken-poller shinken-broker shinken-arbiter shinken-scheduler shinken-receiver mongodb thruk"
for b in $bases
do
	rm -Rf $BASE/$b/files/*
done

chown -R $USER:$USER data/shinken/etc/shinken