SHELL := /bin/bash
IMAGES="mongodb thruk shinken-arbiter shinken-poller shinken-broker shinken-reactionner shinken-receiver shinken-base"
DOCKERUSER=dguenault
MONGOVERSION=2.6.4
SHINKENVERSION=2.0.3
THRUKVERSION=1.84-6

build: build-mongodb build-thruk build-shinken-base build-shinken-arbiter build-shinken-broker build-shinken-receiver build-shinken-scheduler build-shinken-reactionner build-shinken-poller 

pull:
	docker pull $(DOCKERUSER)/mongodb:$(MONGOVERSION)
	docker pull $(DOCKERUSER)/thruk:$(THRUKVERSION)
	docker pull $(DOCKERUSER)/shinken-base:$(SHINKENVERSION)
	docker pull $(DOCKERUSER)/shinken-arbiter:$(SHINKENVERSION)
	docker pull $(DOCKERUSER)/shinken-poller:$(SHINKENVERSION)
	docker pull $(DOCKERUSER)/shinken-broker:$(SHINKENVERSION)
	docker pull $(DOCKERUSER)/shinken-receiver:$(SHINKENVERSION)
	docker pull $(DOCKERUSER)/shinken-reactionner:$(SHINKENVERSION)
	docker pull $(DOCKERUSER)/shinken-scheduler:$(SHINKENVERSION)

clean:	stop rm rmi removefiles

showip:
	-docker inspect --format " {{ .Name }} {{ .NetworkSettings.IPAddress }}" $$(docker ps -q)

stop:
	-docker stop $$(docker ps -q)

rm:	
	-docker rm $$(docker ps -qa)

rmi:
	-docker rmi $$(docker images -qa)

fixowner:
	sudo chown -R $$USER:$$USER data/shinken/etc/shinken
	sudo chown -R $$USER:$$USER data/mongodb

removefiles:
	-find shinken-*/files -exec rm -Rf {} \;		

build-mongodb:
	mkdir -p shinken-mongodb/files
	cp files/supervisor/supervisord.conf shinken-mongodb/files/
	cp files/supervisor/mongodb.conf shinken-mongodb/files/
	cp files/mongodb/10gen.repo shinken-mongodb/files/
	cp files/epel/*.rpm shinken-mongodb/files
	docker build -qt $(DOCKERUSER)/mongodb:$(MONGOVERSION) shinken-mongodb/

build-shinken-base:
	mkdir -p shinken-base/files
	cp files/supervisor/supervisord.conf shinken-base/files/
	cp files/supervisor/sshd.conf shinken-base/files/
	cp -a data/shinken/etc/shinken shinken-base/files/
	docker build -qt $(DOCKERUSER)/shinken-base:$(SHINKENVERSION) shinken-base

build-shinken-arbiter:
	mkdir -p shinken-arbiter/files
	cp files/supervisor/shinken-arbiter.conf shinken-arbiter/files/
	docker build -qt $(DOCKERUSER)/shinken-arbiter:$(SHINKENVERSION) shinken-arbiter/

build-shinken-broker:
	mkdir -p shinken-broker/files
	cp files/supervisor/shinken-broker.conf shinken-broker/files/
	docker build -qt $(DOCKERUSER)/shinken-broker:$(SHINKENVERSION) shinken-broker/

build-shinken-receiver:
	mkdir -p shinken-receiver/files
	cp files/supervisor/shinken-receiver.conf shinken-receiver/files/
	docker build -qt $(DOCKERUSER)/shinken-receiver:$(SHINKENVERSION) shinken-receiver/

build-shinken-scheduler:
	mkdir -p shinken-scheduler/files
	cp files/supervisor/shinken-scheduler.conf shinken-scheduler/files/
	docker build -qt $(DOCKERUSER)/shinken-scheduler:$(SHINKENVERSION) shinken-scheduler/

build-shinken-reactionner:
	mkdir -p shinken-reactionner/files
	cp files/supervisor/shinken-reactionner.conf shinken-reactionner/files/
	docker build -qt $(DOCKERUSER)/shinken-reactionner:$(SHINKENVERSION) shinken-reactionner/

build-shinken-poller:
	mkdir -p shinken-poller/files
	cp files/supervisor/shinken-poller.conf shinken-poller/files/
	docker build -qt $(DOCKERUSER)/shinken-poller:$(SHINKENVERSION) shinken-poller/

build-thruk:
	mkdir -p shinken-thruk/files
	cp files/supervisor/supervisord.conf shinken-thruk/files/
	cp files/supervisor/thruk.conf shinken-thruk/files/
	docker build -qt $(DOCKERUSER)/thruk:$(THRUKVERSION) shinken-thruk/

run-simple-lab:
	fig -f simple-shinken-lab.yml up -d
	fig -f simple-shinken-lab.yml ps

stop-simple-lab:
	fig -f simple-shinken-lab.yml stop

go-broker:
	sudo nsenter --mount --uts --ipc --net --pid --target $$(docker inspect --format {{.State.Pid}} shinkenlab_broker_1)

go-arbiter:
	sudo nsenter --mount --uts --ipc --net --pid --target $$(docker inspect --format {{.State.Pid}} shinkenlab_arbiter_1)
