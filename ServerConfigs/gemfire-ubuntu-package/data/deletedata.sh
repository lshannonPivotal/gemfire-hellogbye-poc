#!/bin/bash
export total=$1
echo "Ok, deleting $total copies"
for ((i=1 ; i <= total ; i++))
do
  rm /home/ubuntu/cluster/gemfire-ubuntu-package/data/2015-07-26-LAX-JFK$i.json
done
echo "Done!"
echo "Enjoy the extra file space!"
