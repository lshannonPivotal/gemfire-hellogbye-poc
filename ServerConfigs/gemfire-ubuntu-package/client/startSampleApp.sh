#!/bin/sh
nohup java -jar /home/ubuntu/cluster/gemfire-ubuntu-package/client/JavaClientSample-0.0.1-SNAPSHOT.jar > /home/ubuntu/cluster/gemfire-ubuntu-package/client/java-client-sample.log 2>&1&
echo $! > /home/ubuntu/cluster/gemfire-ubuntu-package/client/java-client-sample_pid.txt