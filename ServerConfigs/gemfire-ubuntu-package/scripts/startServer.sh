#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
if [ ! -d "$SERVER_DIR_LOCATION/$SERVER_NAME" ]; then
  mkdir $SERVER_DIR_LOCATION/$SERVER_NAME
  echo "Created $SERVER_NAME directory"
fi
gfsh -e "start server --name=$SERVER_NAME --use-cluster-configuration=false --classpath=$CLASSPATH --server-port=40405 --bind-address=$IP_ADDRESS --dir=$SERVER_DIR_LOCATION/$SERVER_NAME --locators=172.31.18.45[10334] --properties-file=$CONF_DIR/gemfire.properties --rebalance=true --cache-xml-file=$CONF_DIR/cache.xml" \
