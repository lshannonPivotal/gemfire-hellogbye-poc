#!/bin/bash
source ./environment.sh
echo "What to upload?"
echo "1: Everything"
echo "2: scripts"
echo "3: conf"
echo "4: lib"
echo "5: data"
read option
if [[ ("$option" -eq "1") ]]; then
	echo "Uploading the Gemfire package to all servers"
	echo "Uploading to Locator 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package ubuntu@$LOCATOR_SERVER_1:/home/ubuntu/cluster
	echo "Uploading to Locator 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package ubuntu@$LOCATOR_SERVER_2:/home/ubuntu/cluster
	echo "Uploading to Server 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package ubuntu@$SERVER_1:/home/ubuntu/cluster
	echo "Uploading to Server 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package ubuntu@$SERVER_2:/home/ubuntu/cluster
fi
if [[ ("$option" -eq "2") ]]; then
	echo "Uploading the scripts to all servers"
	echo "Uploading to Locator 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package/scripts ubuntu@$LOCATOR_SERVER_1:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Locator 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package/scripts ubuntu@$LOCATOR_SERVER_2:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Server 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package/scripts ubuntu@$SERVER_1:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Server 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package/scripts ubuntu@$SERVER_2:/home/ubuntu/cluster/gemfire-ubuntu-package
fi
if [[ ("$option" -eq "3") ]]; then
	echo "Uploading the conf to all servers"
	echo "Uploading to Locator 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package/conf ubuntu@$LOCATOR_SERVER_1:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Locator 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package/conf ubuntu@$LOCATOR_SERVER_2:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Server 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package/conf ubuntu@$SERVER_1:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Server 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package/conf ubuntu@$SERVER_2:/home/ubuntu/cluster/gemfire-ubuntu-package
fi
if [[ ("$option" -eq "4") ]]; then
	echo "Uploading the lib to all servers"
	echo "Uploading to Locator 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package/lib ubuntu@$LOCATOR_SERVER_1:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Locator 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package/lib ubuntu@$LOCATOR_SERVER_2:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Server 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package/lib ubuntu@$SERVER_1:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Server 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package/lib ubuntu@$SERVER_2:/home/ubuntu/cluster/gemfire-ubuntu-package
fi
if [[ ("$option" -eq "5") ]]; then
	echo "Uploading the data to all servers"
	echo "Uploading to Locator 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package/data ubuntu@$LOCATOR_SERVER_1:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Locator 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package/data ubuntu@$LOCATOR_SERVER_2:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Server 1"
	scp -r -i gemfire.pem gemfire-ubuntu-package/data ubuntu@$SERVER_1:/home/ubuntu/cluster/gemfire-ubuntu-package
	echo "Uploading to Server 2"
	scp -r -i gemfire.pem gemfire-ubuntu-package/data ubuntu@$SERVER_2:/home/ubuntu/cluster/gemfire-ubuntu-package
fi