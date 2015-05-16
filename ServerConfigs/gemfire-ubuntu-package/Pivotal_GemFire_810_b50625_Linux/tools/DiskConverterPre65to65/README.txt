Overview
--------
This command line tool converts pre-6.5 oplog files into the GemFire 6.5 
format. It has to work with gemfire 6.5.1.2 and hereafter versions.

5.8 is a special version that we don't support because its gateway event used
different object structure than other versions. 

Cache.xml files for both version of GemFire should be provided. These files 
only need to contain parts related to persistent regions. Non-persist regions,
or attributes such as cache-writer can be omitted. 

However, if a region with enable-gateway="true", it should be kept in new 
version.  Otherwise, some gateway event direct to this region cannot be 
delivered and will cause wan exception.

It's recommended that you use disk-store for better performance, see examples
in this document. However, the old cache.xml file can be used directly for 6.5.

Usage
-----
DiskFileConverter.sh [OLD_CACHE_XML=$NEW_CACHE_XML] [CACHE_XML=$CACHE_XML] 
                     [OLD_GEMFIRE=$OLD_GEMFIRE] [GEMFIRE=$GEMFIRE]

Note: 
1. If parameters are omitted, the script will get these values from 
   environment variables instead.
2. The order of parameters does not matter.
3. If used user class for key or value, CLASSPATH should be set. 
4. All the directories specified in both old and new cache.xml should exist
before running the tool. 

Examples
--------
The following examples can be found below:

* Example 1: disk store for all regions
* Example 2: disk-store for each region
* Example 3: Use pre-6.5 cache.xml for 6.5
* Example 4: Negative scenario
* Example 5: Gateway scenario 
* Example 6: XSLT scenario 


Example 1: disk store for all regions
-------------------------------------
cache.xml files: 
examples/e1_601.xml
examples/e1_65.xml

Command line:

DiskFileConverter.sh OLD_CACHE_XML=examples/e1_601.xml
   NEW_CACHE_XML=examples/e1_65.xml OLD_GEMFIRE=/gemfire601 
   NEW_GEMFIRE=/gemfire6511

Explanation: 

The two persistent regions of the old GemFire file will share the DEFAULT 
disk-store in 6.5. In this example, overflow_data_1 and overflow_data_2 
directories will be under the current directory of its cache.xml file, i.e.
/gemfire601/overflow_data_1 and /gemfire601/overflow_data_2.

The converted oplog files will be under the directory specified by the 6.5
cache.xml (i.e. /tmp/overflow_data).

This is the recommended way to use one disk-store for all persist regions.

$ tools/DiskFileConverter/trunk/deploy/bin/DiskFileConverter.sh OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e1_601.xml CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e1_65.xml

OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e1_601.xml
CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e1_65.xml
OLD_GEMFIRE=/gemfire601
GEMFIRE=/gemfire6511
Creating snapshots for each region...
Loading snapshots to create oplog files...
load snapshot for region /root/region2
load snapshot for region /root/region1
load snapshot for region /root
Verifying created disk-stores

/root: entryCount=1024
/root/region1: entryCount=1024
/root/region2: entryCount=1024
Disk store contains 3072 compactable records.
Total number of region entries in this disk store is: 3072
Reminder: 1. The member using the converted disk files should be started 
             before other members!
          2. Pre-6.5 persist files are supposed to be removed manually

Example 2: disk-store for each region
-------------------------------------

cache.xml files: 
examples/e2_601.xml
examples/e2_65.xml

Command line:

DiskFileConverter.sh OLD_CACHE_XML=examples/e2_601.xml
   NEW_CACHE_XML=examples/e2_65.xml OLD_GEMFIRE=/gemfire601 
   NEW_GEMFIRE=/gemfire6511

Explanation: 

Builds two disk-stores for different configuration of the two persistent 
regions. 

If regions have different configurations, they might need to be put into 
different disk-stores.

Note: 
What makes this different is that each region will have its own disk-store.
But the different attributes such as auto-compact and disk-synchronous do not 
take effect. You can actually use the converted oplog files in a different
configuration as long as the directory is the same and the disk-store name 
is the same. 

$ tools/DiskFileConverter/trunk/deploy/bin/DiskFileConverter.sh OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e2_601.xml CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e2_65.xml

OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e2_601.xml
CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e2_65.xml
OLD_GEMFIRE=/gemfire601
GEMFIRE=/gemfire6511
Creating snapshots for each region...
Loading snapshots to create oplog files...
load snapshot for region /root/region2
load snapshot for region /root/region1
Verifying created disk-stores

/root/region1: entryCount=1024
Total number of region entries in this disk store is: 1024

/root/region2: entryCount=1024
Total number of region entries in this disk store is: 1024
Reminder: 1. The member using the converted disk files should be started 
             before other members!
          2. Pre-6.5 persist files are supposed to be removed manually

Example 3: Use pre-6.5 cache.xml for 6.5
----------------------------------------

Command line:

DiskFileConverter.sh OLD_CACHE_XML=/gemfire601/cache.xml 
   NEW_CACHE_XML=examples/e1_601.xml OLD_GEMFIRE=examples/e1_601.xml
   NEW_GEMFIRE=/gemfire6511

Explanation:

GemFire 6.5 supports backward compatibility. This will work, but it is not 
recommended. 

$ tools/DiskFileConverter/trunk/deploy/bin/DiskFileConverter.sh OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e1_601.xml CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e1_601.xml 

OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e1_601.xml
CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e1_601.xml
OLD_GEMFIRE=/gemfire601
GEMFIRE=/gemfire6511
Creating snapshots for each region...
Loading snapshots to create oplog files...
load snapshot for region /root/region2
load snapshot for region /root/region1
load snapshot for region /root
Verifying created disk-stores

/root: entryCount=1024
Total number of region entries in this disk store is: 1024

/root/region1: entryCount=1024
Total number of region entries in this disk store is: 1024

/root/region2: entryCount=1024
Total number of region entries in this disk store is: 1024
Reminder: 1. The member using the converted disk files should be started 
             before other members!
          2. Pre-6.5 persist files are supposed to be removed manually

Example 4: Negative scenario
----------------------------

Command line:

DiskFileConverter.sh OLD_CACHE_XML=examples/e2_601.xml
   NEW_CACHE_XML=examples/e4_65.xml OLD_GEMFIRE=/gemfire601
   NEW_GEMFIRE=/gemfire6511

Explanation: 

Use cache.xml files from Example 2, but remove the region2 from 6.5's file. 
The converter will print following warning message:

  "Persistent region2 is missing in 6.5, and not converted. 
   Please change your 6.5 cache.xml file and rerun the tool."

$ tools/DiskFileConverter/trunk/deploy/bin/DiskFileConverter.sh OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e2_601.xml CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e4_65.xml

OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e2_601.xml
CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e4_65.xml
OLD_GEMFIRE=/gemfire601
GEMFIRE=/gemfire6511
Creating snapshots for each region...
Loading snapshots to create oplog files...
load snapshot for region /root/region1
Warning: Persistent region /root/region2 is missing in 6.5, and not converted.
Please change your 6.5 cache.xml file and rerun the tool.
Verifying created disk-stores

/root/region1: entryCount=1024
Total number of region entries in this disk store is: 1024
Reminder: 1. The member using the converted disk files should be started 
             before other members!
          2. Pre-6.5 persist files are supposed to be removed manually

Example 5: Gateway scenario 
---------------------------

Explanation: 

Use the WAN example from the provided GemFire examples. Add 
enable-persistence="true" into gateway-queue's attributes.

Start the pre-6.5 example only on us side. After a few minutes, shutdown 
the US side for both client and server.

Run following command to convert:

   export GEMFIRE=/gemfire6511
   DiskFileConverter.sh OLD_CACHE_XML=examples/e5_601.xml 
      CACHE_XML=examples/e5_65.xml OLD_GEMFIRE=/gemfire601

The whole gateway-hub section, in both pre-6.5 and 6.5 cache.xml file, which
looks like this:

  <gateway-hub id="US" port="11111">
    <gateway id="EU">
      <gateway-endpoint id="EU-1" host="localhost" port="33333"/>
      <gateway-queue overflow-directory="overflow" maximum-queue-memory="50"
       batch-size="100" enable-persistence="true" batch-time-interval="1000"/>
    </gateway>
  </gateway-hub>

will be transformed into following automatically:

  <region name="US_EU_EVENT_QUEUE">
    <region-attributes scope="distributed-no-ack"
     data-policy="persistent-replicate">
        <disk-dirs>
          <disk-dir>overflow</disk-dir>
        </disk-dirs>
    </region-attributes>
  </region>

Note: 
1) The gateway configuration should have enable-persistence="true".
2) This 6.5 cache.xml will also be transformed by XSL. 
3) The tool will not replay the persisted entries. 

Restart the WAN example in GemFire 6.5 without the US client. You will see 
that the persisted entries are replayed and arrive at the UK client.

$ cd /gemfire601/examples/dist/wan
$ cd us-hub
$ cacheserver start
$ cd ../us-client
$ java wan.WANClient us (ctrl-C to exit after run a while)
...
Thread-5: Putting key-1294705717881->1294705717881
Thread-2: Putting key-1294705717881->1294705717881
Thread-3: Putting key-1294705717882->1294705717882
$ cd ../us-hub
$ cacheserver stop
$ /tools/DiskFileConverter/trunk/deploy/bin/DiskFileConverter.sh OLD_CACHE_XML=./cache.xml CACHE_XML=/gemfire6511/examples/dist/wan/us-hub/cache.xml
$ cd overflow
$ cp *.crf *.drf *.if /gemfire6511/examples/dist/wan/us-hub/overflow/

$ cd /gemfire6511/examples/dist/wan
$ cd us-hub
$ cacheserver start
$ cd ../eu-hub
$ cacheserver start
cacheserver.log will contain:
...
WANCacheListener received afterCreate event (1568) for region trades:
key-1294705717881->1294705717881
WANCacheListener received afterUpdate event (1569) for region trades:
key-1294705717881->1294705717881
WANCacheListener received afterCreate event (1570) for region trades:
key-1294705717882->1294705717882

Example 6: XSLT scenario 
------------------------

Explanation: 

Repeat example 5 and add following sections into cache.xml:

- bridge-server
- cache-server
- disk-store (in 6.5 only)
- function-service
- serialization-registration
- dynamic-region-factory
- pool
- cache-transaction-manager
- resource-manager
- backup

And add the following sections into the region:

- partition region
- non-persist regions
- region attribute elements: key-constraint, value-constraint, 
  region-time-to-live, region-idle-time,
  entry-time-to-live?, entry-idle-time?, disk-write-attributes?, disk-dirs?,
  partition-attributes?, membership-attributes?, subscription-attributes?,
  cache-loader?, cache-writer?, cache-listener*, eviction-attributes?
- region attributes: concurrency-level, data-policy, early-ack,
  enable-async-conflation, enable-gateway, enable-subscription-conflation,
  hub-id, id, ignore-jta, index-update-type, initial-capacity,
  is-lock-grantor, load-factor, mirror-type, multicast-enabled, persist-backup,
  pool-name, disk-store-name, disk-synchronous, publisher, refid,
  scope, statistics-enabled, cloning-enabled

$ tools/DiskFileConverter/trunk/deploy/bin/DiskFileConverter.sh OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e6_601.xml CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e6_65.xml

OLD_CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e6_601.xml
CACHE_XML=tools/DiskFileConverter/trunk/deploy/examples/e6_65.xml
OLD_GEMFIRE=/gemfire601
GEMFIRE=/gemfire6511
Creating snapshots for each region...
Loading snapshots to create oplog files...
load snapshot for region /root/region2
load snapshot for region /root/region1
load snapshot for region /root
Verifying created disk-stores

/root/region2: entryCount=1024
Total number of region entries in this disk store is: 1024

/root: entryCount=1024
Total number of region entries in this disk store is: 1024

/root/region1: entryCount=1024
Total number of region entries in this disk store is: 1024
Reminder: 1. The member using the converted disk files should be started 
             before other members!
          2. Pre-6.5 persist files are supposed to be removed manually

