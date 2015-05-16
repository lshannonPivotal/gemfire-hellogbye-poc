#!/bin/bash
source ./environment.sh
echo "What set up?"
echo "1: Create directories (new install)"
echo "2: Open permissions on scripts"
echo "3: Create data"
echo "4: Delete data"
read option
if [[ ("$option" -eq "1") ]]; then
	echo "Creating the base"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 mkdir /home/ubuntu/cluster
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 mkdir /home/ubuntu/cluster
	ssh -i gemfire.pem ubuntu@$SERVER_1 mkdir /home/ubuntu/cluster
	ssh -i gemfire.pem ubuntu@$SERVER_2 mkdir /home/ubuntu/cluster
fi
if [[ ("$option" -eq "2") ]]; then
	echo "Opening Permissions"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 chmod +x /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/*.sh
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 chmod +x /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/*.sh
	ssh -i gemfire.pem ubuntu@$SERVER_1 chmod +x /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/*.sh
	ssh -i gemfire.pem ubuntu@$SERVER_2 chmod +x /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/*.sh
fi
if [[ ("$option" -eq "3") ]]; then
	echo "How many copies?"
	read total
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/data/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/data/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/data/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/data/copydata.sh $total
fi
if [[ ("$option" -eq "4") ]]; then
	echo "How many copies?"
	read total
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/data/deletedata.sh $total
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/data/deletedata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_1 /home/ubuntu/cluster/gemfire-ubuntu-package/data/deletedata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_2 /home/ubuntu/cluster/gemfire-ubuntu-package/data/deletedata.sh $total
fi

