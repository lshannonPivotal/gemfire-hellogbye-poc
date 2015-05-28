#!/bin/bash
source ./environment.sh
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1 ls $MEMBERS_DIRECTORY
ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2 ls $MEMBERS_DIRECTORY
ssh -i gemfire.pem ubuntu@$SERVER_1 ls $MEMBERS_DIRECTORY
ssh -i gemfire.pem ubuntu@$SERVER_2 ls $MEMBERS_DIRECTORY

