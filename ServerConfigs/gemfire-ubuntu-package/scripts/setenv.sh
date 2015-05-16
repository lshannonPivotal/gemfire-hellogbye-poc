#!/bin/bash
# Derek Beauregard & Luke Shannon #
# GEMFIRE_WORKING is set on start up #

# Set the GemFire environment variables #
export HOST=localhost
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export USER_HOME=/home/ubuntu/cluster/gemfire-ubuntu-package
export GEMFIRE=$USER_HOME/Pivotal_GemFire_810_b50625_Linux
export GF_JAVA=$JAVA_HOME/bin/java
export CONF_DIR=$USER_HOME/conf
export LIB_DIR=$USER_HOME/lib
export SERVER_DIR_LOCATION=$USER_HOME/members
export IP_ADDRESS=`ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`
export PUBLIC_IP_ADDRESS=`dig +short myip.opendns.com @resolver1.opendns.com`
export LOCATOR_PORT=10334
export LOCATOR_1_IP=172.31.39.160
export LOCATOR_2_IP=172.31.39.161
export PATH=$PATH:$JAVA_HOME/bin:$GEMFIRE/bin
export CLASSPATH=$CLASSPATH:$GEMFIRE/lib/*:$JAVA_HOME/lib/tools.jar:$CONF_DIR/:$CONF_DIR/*:$LIB_DIR/:$LIB_DIR/*
export LOCATOR_NAME="$(hostname)-locator"
export SERVER_NAME="$(hostname)-server"

