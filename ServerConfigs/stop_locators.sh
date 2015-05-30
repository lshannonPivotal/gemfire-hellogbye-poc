#!/bin/bash
source ./environment.sh
echo "Stop the locators"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $SCRIPTS_DIRECTORY/stopLocator.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $SCRIPTS_DIRECTORY/stopLocator.sh 
echo "Done!"

