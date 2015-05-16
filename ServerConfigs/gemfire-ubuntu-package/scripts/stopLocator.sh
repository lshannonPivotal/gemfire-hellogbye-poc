#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
gfsh -e "stop locator --dir=$SERVER_DIR_LOCATION/$LOCATOR_NAME"
echo "$LOCATOR_NAME is stopped"
