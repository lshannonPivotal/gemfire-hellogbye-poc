#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
echo "Type connect --locator=$HOST[$LOCATOR_PORT] to connect to the grid if its running"
gfsh
