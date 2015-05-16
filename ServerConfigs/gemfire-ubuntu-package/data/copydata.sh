#!/bin/bash
export total=$1
echo "Ok, making $total copies"
for ((i=1 ; i <= total ; i++))
do
  cp /home/ubuntu/cluster/gemfire-ubuntu-package/data/2015-07-26-LAX-JFK.json /home/ubuntu/cluster/gemfire-ubuntu-package/data/2015-07-26-LAX-JFK$i.json
done
echo "Enjoy your files!"
