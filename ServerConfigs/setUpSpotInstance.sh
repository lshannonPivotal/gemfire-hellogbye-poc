#!/bin/bash
echo "What is the IP of the Spot Instance?"
read ip
source ./environment.sh
echo "Setting Up Hard Drive"
sudo sgdisk -o /dev/xvdb
sudo sgdisk -n 1:0:0 -c 1:"Linux filesystem" -t 1:8300 /dev/xvdb
sudo mkfs.ext4 /dev/xvdb1
sudo mount -t ext4 /dev/xvdb1 /data
echo "Drive Set Up"
echo "Setting Up The Folders"
ssh -i gemfire.pem ubuntu@$IP mkdir $BASE_DIRECTORY
echo "Uploading Configurations"
scp -r -i gemfire.pem gemfire-ubuntu-package ubuntu@$IP:$BASE_DIRECTORY
echo "Updating Permissions"
ssh -i gemfire.pem ubuntu@$IP chmod +x $SCRIPTS_DIRECTORY/*.sh
echo "Run this for each of the 4 spot instances"
echo "Update environment.sh to use the public IPs"
echo "Update the gemfire-ubuntu-package/scripts/setenv.sh file to specify Locator 1 and 2 of the Spot Instances"

