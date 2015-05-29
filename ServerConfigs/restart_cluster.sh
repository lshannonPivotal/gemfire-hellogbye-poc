#!/bin/bash
source ./environment.sh
echo "Restarting the servers"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $SCRIPTS_DIRECTORY/startServer.sh &
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 $SCRIPTS_DIRECTORY/startServer.sh &
ssh -i gemfire.pem ubuntu@$SERVER_1 $SCRIPTS_DIRECTORY/startServer.sh &
ssh -i gemfire.pem ubuntu@$SERVER_2 $SCRIPTS_DIRECTORY/startServer.sh &

