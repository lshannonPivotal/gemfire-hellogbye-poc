#!/bin/bash
source ./environment.sh
echo "Which machine (just type the leading number ie:'1')?"
echo "1: Locator 1"
echo "2: Locator 2"
echo "3: Server 1"
echo "4: Server 2"
read option
if [[ ("$option" -eq "1") ]]; then
	echo "Logging into: $LOCATOR_SERVER_1"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_1
fi

if [[ ("$option" -eq "2") ]]; then
	echo "Logging into: $LOCATOR_SERVER_2"
	ssh -i gemfire.pem ubuntu@$LOCATOR_SERVER_2
fi

if [[ ("$option" -eq "3") ]]; then
	echo "Logging into: $SERVER_1"
	ssh -i gemfire.pem ubuntu@$SERVER_1
fi

if [[ ("$option" -eq "4") ]]; then
	echo "Logging into: $SERVER_2"
	ssh -i gemfire.pem ubuntu@$SERVER_2
fi

