#!/bin/bash

vagrant ssh -c 'sudo tail -q -f /var/log/mesos/mesos-master.FATAL -f /var/log/mesos/mesos-master.INFO -f /var/log/mesos/mesos-master.WARNING -f /var/log/mesos/mesos-master.ERROR' $1
