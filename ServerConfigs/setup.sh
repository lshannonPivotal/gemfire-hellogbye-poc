#!/bin/bash
source ./environment.sh
echo "What set up?"
echo "1: Create directories (new install)"
echo "2: Open permissions on scripts"
echo "3: Create data"
echo "4: Delete data"
echo "5: Start Client Application"
echo "6: Stop Client Application"
read option
if [[ ("$option" -eq "1") ]]; then
	echo "Creating the base"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 mkdir $BASE_DIRECTORY
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 mkdir $BASE_DIRECTORY
	ssh -i gemfire.pem ubuntu@$SERVER_1 mkdir $BASE_DIRECTORY
	ssh -i gemfire.pem ubuntu@$SERVER_2 mkdir $BASE_DIRECTORY
fi
if [[ ("$option" -eq "2") ]]; then
	echo "Opening Permissions"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 chmod +x $SCRIPTS_DIRECTORY/*.sh
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 chmod +x $DATA_DIRECTORY/*.sh
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 chmod +x $SCRIPTS_DIRECTORY/*.sh
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 chmod +x $DATA_DIRECTORY/*.sh
	ssh -i gemfire.pem ubuntu@$SERVER_1 chmod +x $SCRIPTS_DIRECTORY/*.sh
	ssh -i gemfire.pem ubuntu@$SERVER_1 chmod +x $DATA_DIRECTORY/*.sh
	ssh -i gemfire.pem ubuntu@$SERVER_2 chmod +x $SCRIPTS_DIRECTORY/*.sh
	ssh -i gemfire.pem ubuntu@$SERVER_2 chmod +x $DATA_DIRECTORY/*.sh
fi
if [[ ("$option" -eq "3") ]]; then
	echo "How many copies?"
	read total
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $DATA_DIRECTORY/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $DATA_DIRECTORY/listdata.sh
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $DATA_DIRECTORY/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $DATA_DIRECTORY/listdata.sh
	ssh -i gemfire.pem ubuntu@$SERVER_1 $DATA_DIRECTORY/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_1 $DATA_DIRECTORY/listdata.sh
	ssh -i gemfire.pem ubuntu@$SERVER_2 $DATA_DIRECTORY/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_2 $DATA_DIRECTORY/listdata.sh
fi
if [[ ("$option" -eq "4") ]]; then
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $DATA_DIRECTORY/deletedata.sh
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $DATA_DIRECTORY/listdata.sh
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $DATA_DIRECTORY/deletedata.sh
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $DATA_DIRECTORY/listdata.sh
	ssh -i gemfire.pem ubuntu@$SERVER_1 $DATA_DIRECTORY/deletedata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_1 $DATA_DIRECTORY/listdata.sh
	ssh -i gemfire.pem ubuntu@$SERVER_2 $DATA_DIRECTORY/deletedata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_2 $DATA_DIRECTORY/listdata.sh
fi
if [[ ("$option" -eq "5") ]]; then
	echo "Starting the client application in: $PACKAGE_DIRECTORY/client/startSampleApp.sh"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $PACKAGE_DIRECTORY/client/startSampleApp.sh
	echo "http://ec2-52-0-225-28.compute-1.amazonaws.com:8080/home"
fi
if [[ ("$option" -eq "6") ]]; then
	echo "Stopping the client application in: $PACKAGE_DIRECTORY/client/stopSampleApp.sh"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $PACKAGE_DIRECTORY/client/stopSampleApp.sh
fi

