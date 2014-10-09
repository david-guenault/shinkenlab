#!/bin/bash

name=$1

pid=$(docker inspect --format {{.State.Pid}} $1)

nsenter --mount --uts --ipc --net --pid --target $pid