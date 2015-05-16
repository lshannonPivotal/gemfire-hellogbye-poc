Pivotal GemFire Log Collection Utility
======================================

This utility is used to gather log files from a GemFire cluster.  In the default mode
this requires that a GemFire process be running on each machine that this tool is to gather
logs from.  If you would like to collect log files from machines in which a GemFire process
is not running, you can use the "Static Copy Mode".  See the "Current Usage" section for 
details on using "Static Copy Mode".
 

Current Usage
=============
java -jar gfe-logcollect.jar -c <company> -o <output dir> [OPTIONS]

Required arguments:
        -c company name to append to output filename
        -o output directory to store all collected log files

Optional arguments:
        -a comma separated list of hosts with no spaces. EG. host1,host2,host3 (defaults to localhost)
        -u username to use to connect via ssh (defaults to current user)
        -i identity file to use for PKI based ssh (defaults to ~/.ssh/id_[dsa|rsa]
        -p prompt for a password to use for ssh connections
        -t ticket number to append to created zip file
        -d don't clean up collected log files after the zip has been created
        -s send the zip file to Pivotal support
        -f ftp server to upload collected logs to.  Defaults to ftp.gemstone.com
        -v print version of this utility
        -h print this help information

Static Copy Mode
        -m <file> Use a file with log locations instead of scanning for logs.
           Entries should be in the format hostname:/log/location


Known Limitations
=================
1. Only supports Linux hosts.
2. Requires SSH access between machines.
3. Requires that the username be the same for each host that this app scans. 
   EG. you can't specify user@host1, anotherUser@host2, etc.
4. Requires that SSH access is available across all hosts using either the same 
   password or the same public key.
5. In order to get stacks using jstack, this process must be ran as the same user
   who owns the gfxd process.  
6. Requires 'jps' (typically in $JAVA_HOME/bin) to be in the user's PATH on each
   machine.


Copyright
=========
2014 Pivotal Software, Inc.  All Rights Reserved. This
product is protected by U.S. and international copyright and
intellectual property laws. Pivotal products are covered by one
or more patents listed at http://www.gopivotal.com/patents.


