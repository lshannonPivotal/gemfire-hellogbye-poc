#!/bin/bash
source /home/ubuntu/cluster/gemfire-ubuntu-package/scripts/setenv.sh
gfsh run --file=serverStart.gf
echo "Stop Commands Completed"
echo "Done!"
