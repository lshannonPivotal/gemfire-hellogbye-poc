#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
if [ ! -d "$SERVER_DIR_LOCATION/$SERVER_NAME2" ]; then
  mkdir $SERVER_DIR_LOCATION/$SERVER_NAME2
  mkdir $SERVER_DIR_LOCATION/$SERVER_NAME2/data
  echo "Created $SERVER_NAME2 directory"
fi
gfsh -e "start server --name=$SERVER_NAME2 --use-cluster-configuration=false --classpath=$CLASSPATH --bind-address=$PUBLIC_DNS --dir=$SERVER_DIR_LOCATION/$SERVER_NAME2 --locators=$LOCATOR_1_IP[$LOCATOR_PORT],$LOCATOR_2_IP[$LOCATOR_PORT] --properties-file=$CONF_DIR/gemfire.properties --rebalance=true --J=-Xms31g --J=-Xmx31g --cache-xml-file=$CONF_DIR/cache.xml"
