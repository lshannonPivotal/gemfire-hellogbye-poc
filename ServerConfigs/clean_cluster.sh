#!/bin/bash
source ./environment.sh
echo "Cleaning Up"
ssh -i gemfire.pem ubuntu@$SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/clean_up.sh
ssh -i gemfire.pem ubuntu@$SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/clean_up.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/clean_up.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/clean_up.sh

