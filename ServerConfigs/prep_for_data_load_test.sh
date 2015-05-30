#!/bin/bash
source ./environment.sh
echo "*************************************"
echo "* Preparing for the Data Load Test *"
echo "*************************************"
echo "Re-Generate Data Files?"
echo "135000 will create 30GB"
echo "Type: 'yes' to regenerate"
read regen

if [ "$regen" == "yes" ]; then

	echo "*************************************"
	echo "* Listing and Cleaning Up Data File *"
	echo "*************************************"
	echo "Listing Files In Data Directory: $LOCATOR_SERVER_1 $DATA_DIRECTORY"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $DATA_DIRECTORY/listdata.sh
	echo "Cleaning up the data files"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $DATA_DIRECTORY/deletedata.sh
	
	echo "Listing Files In Data Directory: $LOCATOR_SERVER_2 $DATA_DIRECTORY"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $DATA_DIRECTORY/listdata.sh
	echo "Cleaning up the data files"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $DATA_DIRECTORY/deletedata.sh
	
	echo "Listing Files In Data Directory: $SERVER_1 $DATA_DIRECTORY"
	ssh -i gemfire.pem ubuntu@$SERVER_1 $DATA_DIRECTORY/listdata.sh
	echo "Cleaning up the data files"
	ssh -i gemfire.pem ubuntu@$SERVER_1 $DATA_DIRECTORY/deletedata.sh
	
	echo "Listing Files In Data Directory: $SERVER_2 $DATA_DIRECTORY"
	ssh -i gemfire.pem ubuntu@$SERVER_2 $DATA_DIRECTORY/listdata.sh
	echo "Cleaning up the data files"
	ssh -i gemfire.pem ubuntu@$SERVER_2 $DATA_DIRECTORY/deletedata.sh
	
	echo "*************************************"
	echo "* Generating New Data Files         *"
	echo "*************************************"
	echo "Re-Generating Data Files?"
	echo "How many copies?"
	read total
	echo "Creating files in: $LOCATOR_SERVER_1"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $DATA_DIRECTORY/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $DATA_DIRECTORY/listdata.sh

	echo "Creating files in: $LOCATOR_SERVER_2"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $DATA_DIRECTORY/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $DATA_DIRECTORY/listdata.sh
	
	echo "Creating files in: $SERVER_1"
	ssh -i gemfire.pem ubuntu@$SERVER_1 $DATA_DIRECTORY/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_1 $DATA_DIRECTORY/listdata.sh
	
	echo "Creating files in: $SERVER_2"
	ssh -i gemfire.pem ubuntu@$SERVER_2 $DATA_DIRECTORY/copydata.sh $total
	ssh -i gemfire.pem ubuntu@$SERVER_2 $DATA_DIRECTORY/listdata.sh
fi

echo "*************************************"
echo "* Cleaning Up Gemfire Directories   *"
echo "*************************************"
./clean_cluster.sh

echo "*************************************"
echo "* Starting Up Clean Gemfire Cluster *"
echo "*************************************"
./start_cluster.sh

echo "*************************************"
echo "* Start The Sample Application      *"
echo "*************************************"
echo "Starting the client application in: $PACKAGE_DIRECTORY/client/startSampleApp.sh"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $PACKAGE_DIRECTORY/client/startSampleApp.sh
echo "To begin the test click the 'function' link:"
echo "http://ec2-52-0-225-28.compute-1.amazonaws.com:8080/home"


