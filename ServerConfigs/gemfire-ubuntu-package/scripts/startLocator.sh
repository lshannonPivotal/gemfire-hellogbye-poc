#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
if [ ! -d "$SERVER_DIR_LOCATION/$LOCATOR_NAME" ]; then
	mkdir $SERVER_DIR_LOCATION/$LOCATOR_NAME
	echo "Created the $LOCATOR_NAME directory"
fi
echo "Starting Up: $LOCATOR_NAME running on $IP_ADDRESS on port $LOCATOR_PORT"
gfsh -e "start locator --name=$LOCATOR_NAME --locators=$LOCATOR_1_IP[$LOCATOR_PORT],$LOCATOR_2_IP[$LOCATOR_PORT] --bind-address=$IP_ADDRESS --enable-cluster-configuration=false --dir=$SERVER_DIR_LOCATION/$LOCATOR_NAME --port=$LOCATOR_PORT --J=-Xms1g --J=-Xmx1g --J=-XX:+PrintFlagsFinal --log-level=error"