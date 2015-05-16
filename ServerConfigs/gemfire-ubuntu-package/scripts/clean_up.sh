#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
if [ -d "$SERVER_DIR_LOCATION/$SERVER_NAME" ]; then
	rm -fr $SERVER_DIR_LOCATION/$SERVER_NAME
	echo "$SERVER_DIR_LOCATION/$SERVER_NAME deleted"
fi
if [ -d "$SERVER_DIR_LOCATION/$LOCATOR_NAME" ]; then
	rm -fr $SERVER_DIR_LOCATION/$LOCATOR_NAME
	echo "$SERVER_DIR_LOCATION/$LOCATOR_NAME deleted"
fi
