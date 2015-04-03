#!/bin/bash

vagrant ssh -c 'sudo tail -q -f /var/log/zookeeper/zookeeper.log' $1
