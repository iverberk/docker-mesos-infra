#!/bin/bash

masters=( "$@" )

for master in "${masters[@]}"
do
    vagrant ssh $master -c 'sudo service mesos-master start'
done

exit 0
