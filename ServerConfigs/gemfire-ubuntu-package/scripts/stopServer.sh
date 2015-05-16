#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
gfsh -e "stop server --dir=$SERVER_DIR_LOCATION/$SERVER_NAME"
echo "Stop Commands Completed"
