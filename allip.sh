#!/bin/bash
docker inspect --format '{{ .Name }} {{ .NetworkSettings.IPAddress }}' $(docker ps -qa)