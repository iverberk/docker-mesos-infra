#!/bin/bash

vagrant ssh -c 'sudo tail -q -f /var/log/syslog | grep -v Recovered | grep -v offers | grep -v http' $1
