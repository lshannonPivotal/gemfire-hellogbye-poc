#!/bin/sh
nohup java -jar JavaClientSample-0.0.1-SNAPSHOT.jar > java-client-sample.log 2>&1&
echo $! > java-client-sample_pid.txt