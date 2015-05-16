#!/bin/bash
source ./environment.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 ls /home/ubuntu/cluster/gemfire-ubuntu-package/members
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 ls /home/ubuntu/cluster/gemfire-ubuntu-package/members
ssh -i gemfire.pem ubuntu@$SERVER_1 ls /home/ubuntu/cluster/gemfire-ubuntu-package/members
ssh -i gemfire.pem ubuntu@$SERVER_2 ls /home/ubuntu/cluster/gemfire-ubuntu-package/members

