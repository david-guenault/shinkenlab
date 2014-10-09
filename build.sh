#!/bin/bash
BASE=$(readlink -f $(dirname $0))

COVERAGE=$1

case "$COVERAGE" in 
	"ALL")
		MONGODB="BUILD"
		THRUK="BUILD"
		SHINKENBASE="BUILD"
		SHINKENARBITER="BUILD"
		SHINKENPOLLER="BUILD"
		SHINKENBROKER="BUILD"
		SHINKENSCHEDULER="BUILD"
		SHINKENRECEIVER="BUILD"
		SHINKENREACTIONNER="BUILD"
		;;
	"MONGODB")
		MONGODB="BUILD"
		;;
	"THRUK")
		THRUK="BUILD"
		;;
	"BASE") 
		SHINKENBASE="BUILD"
		;;
	"ARBITER")
		SHINKENARBITER="BUILD"
		;;
	"POLLER")
		SHINKENPOLLER="BUILD"
		;;
	"BROKER")
		SHINKENBROKER="BUILD"
		;;
	"REACTIONNER")
		SHINKENREACTIONNER="BUILD"
		;;
	"RECEIVER")
		SHINKENRECEIVER="BUILD"
		;;
	"SCHEDULER")
		SHINKENSCHEDULER="BUILD"
		;;
	*)
		exit
esac

if [ "$MONGODB" == "BUILD" ]
then
	# build mongodb image
	mkdir -p $BASE/mongodb/files
	cp $BASE/files/supervisor/supervisord.conf $BASE/mongodb/files/
	cp $BASE/files/supervisor/mongodb.conf $BASE/mongodb/files/
	cp $BASE/files/mongodb/10gen.repo $BASE/mongodb/files/
	cp $BASE/files/epel/*.rpm $BASE/mongodb/files
	cd $BASE/mongodb && docker build -qt dguenault/mongodb:2.6.4 .
fi 

if [ "$THRUK" == "BUILD" ]
then
	# build thruk image
	mkdir -p $BASE/thruk/files
	cp $BASE/files/supervisor/supervisord.conf $BASE/thruk/files/
	cp $BASE/files/supervisor/thruk.conf $BASE/thruk/files/
	cd $BASE/thruk && docker build -qt dguenault/thruk:1.84-6 .
fi

if [ "$SHINKENBASE" == "BUILD" ]
then
	#build shinken base image
	mkdir -p $BASE/shinken-base/files
	cp $BASE/files/supervisor/supervisord.conf $BASE/shinken-base/files/
	cd $BASE/shinken-base && docker build -qt dguenault/shinken-base:2.0.3 .
fi

if [ "$SHINKENARBITER" == "BUILD" ]
then
	#build shinken arbiter image based on shinken-base
	mkdir -p $BASE/shinken-arbiter/files
	cp $BASE/files/supervisor/shinken-arbiter.conf $BASE/shinken-arbiter/files/
	cd $BASE/shinken-arbiter && docker build -qt dguenault/shinken-arbiter:2.0.3 .
fi

if [ "$SHINKENBROKER" == "BUILD" ]
then
	#build shinken broker image based on shinken-base
	mkdir -p $BASE/shinken-broker/files
	cp $BASE/files/supervisor/shinken-broker.conf $BASE/shinken-broker/files/
	cd $BASE/shinken-broker && docker build -qt dguenault/shinken-broker:2.0.3 .
fi

if [ "$SHINKENRECEIVER" == "BUILD" ]
then
	#build shinken receiver image based on shinken-base
	mkdir -p $BASE/shinken-receiver/files
	cp $BASE/files/supervisor/shinken-receiver.conf $BASE/shinken-receiver/files/
	cd $BASE/shinken-receiver && docker build -qt dguenault/shinken-receiver:2.0.3 .
fi

if [ "$SHINKENSCHEDULER" == "BUILD" ]
then
	#build shinken scheduler image based on shinken-base
	mkdir -p $BASE/shinken-scheduler/files
	cp $BASE/files/supervisor/shinken-scheduler.conf $BASE/shinken-scheduler/files/
	cd $BASE/shinken-scheduler && docker build -qt dguenault/shinken-scheduler:2.0.3 .
fi

if [ "$SHINKENREACTIONNER" == "BUILD" ]
then
	#build shinken reactionner image based on shinken-base
	mkdir -p $BASE/shinken-reactionner/files
	cp $BASE/files/supervisor/shinken-reactionner.conf $BASE/shinken-reactionner/files/
	cd $BASE/shinken-reactionner && docker build -qt dguenault/shinken-reactionner:2.0.3 .
fi

if [ "$SHINKENPOLLER" == "BUILD" ]
then
	#build shinken poller image based on shinken-base
	mkdir -p $BASE/shinken-poller/files
	cp $BASE/files/supervisor/shinken-poller.conf $BASE/shinken-poller/files/
	cd $BASE/shinken-poller && docker build -qt dguenault/shinken-poller:2.0.3 .
fi