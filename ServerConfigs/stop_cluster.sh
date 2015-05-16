#!/bin/bash
source ./environment.sh
echo "Stop the servers"
ssh -i gemfire.pem ubuntu@$SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/stopServer.sh
ssh -i gemfire.pem ubuntu@$SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/stopServer.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/stopServer.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/stopServer.sh

echo "Stop the locators"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/stopLocator.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/stopLocator.sh


