#!/bin/bash

nodes=( "$@" )

for node in "${nodes[@]}"
do
    echo "Killing Consul on $node"
    vagrant ssh -c "sudo service docker-consul-app stop &> /dev/null" $node -- -q 
    consul=$(vagrant ssh -c "sudo docker ps | grep consul" $node -- -q)
    if [ ! -z "$consul" ]; then
        vagrant ssh -c "sudo docker rm -f \$(sudo docker ps | grep consul | awk '{ print \$1 }')" $node -- -q
    fi
done

exit 0
