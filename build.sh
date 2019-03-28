#!/bin/bash
PUID=`id -u` PGID=`id -g` docker-compose build --no-cache
rm .env  2> /dev/null
echo "PUID=$(id -u)" >> .env
echo "PGID=$(id -g)" >> .env
