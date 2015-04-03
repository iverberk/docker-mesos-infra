#!/bin/bash

nodes=( "$@" )

for node in "${nodes[@]}"
do
    echo "Starting Registrator on $node"
    vagrant ssh -c "sudo service docker-registrator-app start &> /dev/null" $node -- -q 
done

exit 0
