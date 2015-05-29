#!/bin/bash
find /home/ubuntu/cluster/gemfire-ubuntu-package/data -name "*.json" -print0 | xargs -0 rm
echo "Done!"
echo "Enjoy the extra file space!"
