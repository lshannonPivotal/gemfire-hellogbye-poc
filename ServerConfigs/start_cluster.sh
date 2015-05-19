#!/bin/bash
source ./environment.sh
now=$(date +"%T")
echo "Start Time : $now"
echo "Start the locators"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/startLocator.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/startLocator.sh
echo "Start the servers"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/startServer.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/startServer.sh
ssh -i gemfire.pem ubuntu@$SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/startServer.sh
ssh -i gemfire.pem ubuntu@$SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/startServer.sh
now=$(date +"%T")
echo "End Time : $now"
echo "Done!"

