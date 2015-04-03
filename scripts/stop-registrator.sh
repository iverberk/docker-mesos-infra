#!/bin/bash

nodes=( "$@" )

for node in "${nodes[@]}"
do
    echo "Killing Registrator on $node"
    vagrant ssh -c "sudo service docker-registrator-app stop &> /dev/null" $node -- -q 
    registrator=$(vagrant ssh -c "sudo docker ps | grep registrator" $node -- -q)
    if [ ! -z "$registrator" ]; then
        vagrant ssh -c "sudo docker rm -f \$(sudo docker ps | grep registrator | awk '{ print \$1 }')" $node
    fi
done

exit 0
