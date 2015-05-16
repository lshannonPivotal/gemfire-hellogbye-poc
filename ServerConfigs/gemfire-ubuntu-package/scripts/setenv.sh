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
export LOCATOR_PORT=10334
export PATH=$PATH:$JAVA_HOME/bin:$GEMFIRE/bin
export CLASSPATH=$CLASSPATH:$GEMFIRE/lib/*:$JAVA_HOME/lib/tools.jar:$CONF_DIR/:$CONF_DIR/*:$LIB_DIR/:$LIB_DIR/*
export LOCATOR_NAME="$(hostname)-locator"
export SERVER_NAME="$(hostname)-server"

#Server Configuration #
export GF_JAVA_OPT="-server,-verbose:gc,-XX:+PrintGCTimeStamps,-XX:+PrintGCDetails,-Xloggc:gc.log\
,-Xms40g,-Xmx40g\
,-XX:+UseConcMarkSweepGC,-XX:+UseParNewGC\
,-XX:CMSInitiatingOccupancyFraction=90\
,-XX:+UseCompressedOops"

#GFSH logging
export JAVA_ARGS="-Dgfsh.log-dir=$GEMFIRE_WORKING/logs-gfsh "
