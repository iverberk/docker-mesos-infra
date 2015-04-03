#!/bin/bash

masters=( mm1 mm2 mm3 )

for master in "${masters[@]}"
do
    vagrant ssh $master -c 'sudo service marathon stop'
done

exit 0
