#!/bin/bash

nodes=( "$@" )

for node in "${nodes[@]}"
do
    echo "Starting Consul on $node"
    vagrant ssh -c "sudo service docker-consul-app start &> /dev/null" $node -- -q 
done

exit 0
