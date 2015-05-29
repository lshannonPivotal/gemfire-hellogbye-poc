#!/bin/bash
source ./environment.sh
now=$(date +"%T")
echo "Start Time : $now"
echo "Start the locators"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $SCRIPTS_DIRECTORY/startLocator.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $SCRIPTS_DIRECTORY/startLocator.sh 
echo "Start the servers"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $SCRIPTS_DIRECTORY/startServer.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $SCRIPTS_DIRECTORY/startServer.sh
ssh -i gemfire.pem ubuntu@$SERVER_1 $SCRIPTS_DIRECTORY/startServer.sh
ssh -i gemfire.pem ubuntu@$SERVER_2 $SCRIPTS_DIRECTORY/startServer.sh
now=$(date +"%T")
echo "End Time : $now"
echo "Done!"

