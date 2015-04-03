#!/bin/bash

nodes=( "$@" )

for node in "${nodes[@]}"
do
    vagrant ssh -c "sudo docker ps -a | grep app | awk '{ print \$1 }' | xargs sudo docker rm -f" $node
done

exit 0
