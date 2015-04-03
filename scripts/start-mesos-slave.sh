#!/bin/bash

slaves=( "$@" )

for slave in "${slaves[@]}"
do
    vagrant ssh $slave -c 'sudo service mesos-slave start'
done

exit 0
