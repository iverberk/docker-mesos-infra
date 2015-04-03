#!/bin/bash

masters=( "$@" )

for master in "${masters[@]}"
do
    vagrant ssh $master -c 'sudo service mesos-slave stop'
done

exit 0
