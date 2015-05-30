#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
echo "Type connect --locator=$LOCATOR_1_IP[$LOCATOR_PORT] to connect to the grid if its running"
gfsh
