#!/bin/sh
CONF_PATH=/etc/trafficserver
EXTRA_CONFS=/tmp/trafficserver/*
for f in $EXTRA_CONFS
do
  name=$(basename "$f")
  echo "create symlink for extra config $name"
  [ -f $CONF_PATH/$name ] && rm $CONF_PATH/$name
  ln -s $f $CONF_PATH
done
traffic_server
