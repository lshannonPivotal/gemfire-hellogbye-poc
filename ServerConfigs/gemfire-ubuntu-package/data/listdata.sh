#!/bin/bash
echo "Size the data folder:"
du -h /home/ubuntu/cluster/gemfire-ubuntu-package/data
echo "Count of JSON files:"
ls /home/ubuntu/cluster/gemfire-ubuntu-package/data/*.json | wc 
