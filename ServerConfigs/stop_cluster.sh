#!/bin/bash
source ./environment.sh
echo "Starting Shut Down"
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 $SCRIPTS_DIRECTORY/shutdownCluster.sh
echo "Done!"


