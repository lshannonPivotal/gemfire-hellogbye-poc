#!/bin/sh
kill -9 `cat java-client-sample_pid.txt`
rm -f java-client-sample.log
rm -f java-client-sample_pid.txt