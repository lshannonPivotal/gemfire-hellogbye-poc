#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
if [ -d "$SERVER_DIR_LOCATION/$SERVER_NAME" ]; then
	rm -fr $SERVER_DIR_LOCATION/$SERVER_NAME
	echo "$SERVER_DIR_LOCATION/$SERVER_NAME deleted"
	pkill java
	echo "All Java Processes Killed"
fi
if [ -d "$SERVER_DIR_LOCATION/$LOCATOR_NAME" ]; then
	rm -fr $SERVER_DIR_LOCATION/$LOCATOR_NAME
	echo "$SERVER_DIR_LOCATION/$LOCATOR_NAME deleted"
	echo "All Java Processes Killed"
fi
