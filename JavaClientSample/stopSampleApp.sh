#!/bin/sh
kill -9 `cat /home/ubuntu/cluster/gemfire-ubuntu-package/client/java-client-sample_pid.txt`
rm -f /home/ubuntu/cluster/gemfire-ubuntu-package/client/java-client-sample.log
rm -f /home/ubuntu/cluster/gemfire-ubuntu-package/client/java-client-sample_pid.txt