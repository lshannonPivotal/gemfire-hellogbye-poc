#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
if [ ! -d "$SERVER_DIR_LOCATION/$LOCATOR_NAME" ]; then
	mkdir $SERVER_DIR_LOCATION/$LOCATOR_NAME
	echo "Created the $LOCATOR_NAME directory"
fi
echo "Starting Up: $LOCATOR_NAME running on $IP_ADDRESS on port $LOCATOR_PORT"
if [ $IP_ADDRESS == $LOCATOR_2_IP ] ; then
	export OTHER_LOCATOR=$LOCATOR_2_IP
else
	export OTHER_LOCATOR=$LOCATOR_1_IP
fi
gfsh -e "start locator --name=$LOCATOR_NAME --locators=$OTHER_LOCATOR[$LOCATOR_PORT] --enable-cluster-configuration=false --dir=$SERVER_DIR_LOCATION/$LOCATOR_NAME --port=$LOCATOR_PORT --J=-Xms1g --J=-Xmx1g --log-level=error --J=-Dcom.sun.management.jmxremote --J=-Dcom.sun.management.jmxremote.port=15666 --J=-Dcom.sun.management.jmxremote.ssl=false --J=-Dcom.sun.management.jmxremote.authenticate=false --J=-Dcom.sun.management.jmxremote.local.only=false --J=-Djava.rmi.server.hostname=$IP_ADDRESS"
