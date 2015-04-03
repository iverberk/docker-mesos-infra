#!/bin/bash

./stop-registrator.sh mm1 mm2 mm3 ms1 ms2 ms3 ms4
./clear-consul-app.php
./stop-consul.sh mm1 mm2 mm3 ms1 ms2 ms3 ms4
./stop-mesos-slave.sh ms1 ms2 ms3 ms4
./stop-marathon.sh mm1 mm2 mm3
./stop-mesos-master.sh mm1 mm2 mm3
vagrant ssh -c "sudo /usr/share/zookeeper/bin/zkCli.sh --cmd rmr /zookeeper && sudo /usr/share/zookeeper/bin/zkCli.sh --cmd rmr /mesos && sudo /usr/share/zookeeper/bin/zkCli.sh --cmd rmr /marathon" mm1
./stop-zookeeper.sh mm1 mm2 mm3
./start-zookeeper.sh mm1 mm2 mm3
./start-mesos-master.sh mm1 mm2 mm3
./start-marathon.sh mm1 mm2 mm3
./start-mesos-slave.sh ms1 ms2 ms3 ms4
./clear-app-containers.sh
./start-consul.sh mm1 mm2 mm3 ms1 ms2 ms3 ms4
./start-registrator.sh mm1 mm2 mm3 ms1 ms2 ms3 ms4

exit 0
