#!/bin/bash

masters=( "$@" )

for master in "${masters[@]}"
do
    vagrant ssh $master -c 'sudo service zookeeper start'
done

exit 0
