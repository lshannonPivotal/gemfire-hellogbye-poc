#!/bin/bash
source ./environment.sh
echo "Cleaning Up"
echo "Cleaning Up: $SERVER_2"
ssh -i gemfire.pem ubuntu@$SERVER_2 $SCRIPTS_DIRECTORY/clean_up.sh
echo "Cleaning Up: $SERVER_1"
ssh -i gemfire.pem ubuntu@$SERVER_1 $SCRIPTS_DIRECTORY/clean_up.sh
echo "Cleaning Up: $LOCATOR_SERVER_2"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $SCRIPTS_DIRECTORY/clean_up.sh
echo "Cleaning Up: $LOCATOR_SERVER_1"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $SCRIPTS_DIRECTORY/clean_up.sh
echo "Done!"

