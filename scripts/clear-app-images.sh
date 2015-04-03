#!/bin/bash

nodes=( "$@" )

for node in "${nodes[@]}"
do
    vagrant ssh -c "docker images | grep app | awk '{ print \$3 }' | xargs docker rmi" $node
done

exit 0
