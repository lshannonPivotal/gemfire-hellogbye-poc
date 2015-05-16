#!/bin/bash

printUsage() 
{
  echo "Usage: DiskFileConverter.sh [OLD_CACHE_XML=\$OLD_CACHE_XML] [CACHE_XML=\$CACHE_XML] [OLD_GEMFIRE=\$OLD_GEMFIRE] [GEMFIRE=\$GEMFIRE] [CLASSPATH=\$CLASSPATH]"
  echo "Note: No space is allowed around the '=' sign"
  exit
}

getCurDir()
{
cwd=`dirname $0`
newcwd=`echo $cwd | sed -e 's/^\..*//'`
if [ "$newcwd" = "" ]; then
  olddir=`pwd`
  cd $cwd
  cwd=`pwd`
  cd $olddir
fi
}

if [ "$1" = "-h" -o $# -eq 0 ]; then
  printUsage
fi

which java
if [ $? -ne 0 ]; then
  echo "java is not in path"
  exit
fi

if [ $# != 0 ]; then
  for arg in $*
  do
    if [ "$arg" = "=" ]; then
      printUsage
    fi
    export $arg
  done
fi

if [ "$OLD_GEMFIRE" = "" -o "$GEMFIRE" = "" ]; then
  echo OLD_GEMFIRE and GEMFIRE should be specified
  exit
fi

if [ "$OLD_CACHE_XML" = "" -o "$CACHE_XML" = "" ]; then
  echo OLD_CACHE_XML and CACHE_XML should be specified
  exit
fi

echo OLD_CACHE_XML=$OLD_CACHE_XML
echo CACHE_XML=$CACHE_XML
echo OLD_GEMFIRE=$OLD_GEMFIRE
echo GEMFIRE=$GEMFIRE
echo CLASSPATH=$CLASSPATH

getCurDir

# step 1: XSLT for old gemfire
java -cp $cwd/../lib/DiskFileConverter.jar:$OLD_GEMFIRE/lib/gemfire.jar patch.CacheXmlTransform $cwd/DiskFileConverter.xsl $OLD_CACHE_XML

# step 2: create snapshots
echo "Creating snapshots for each region..."
java -cp $OLD_GEMFIRE/lib/gemfire.jar:$cwd/../lib/DiskFileConverter.jar:$CLASSPATH patch.CreateSnapShot $OLD_CACHE_XML
if [ $? -ne 0 ]; then
  echo "Error creating snapshots, exiting"
  exit
fi
rm ${OLD_CACHE_XML}.xslt 2>/dev/null

# step 3: XSLT for new gemfire
java -cp $cwd/../lib/DiskFileConverter.jar:$GEMFIRE/lib/gemfire.jar patch.CacheXmlTransform $cwd/DiskFileConverter.xsl $CACHE_XML

# step 4: load snapshots and create persist files
echo "Loading snapshots to create oplog files..."
java -cp $GEMFIRE/lib/gemfire.jar:$cwd/../lib/DiskFileConverter.jar:$CLASSPATH patch.CreatePersistFile $CACHE_XML
ret=$?
if [ $ret -ne 0 ]; then
  echo "Some errors happened. "
  exit 1
fi

# step 5: verify disk stores
echo "Verifying created disk-stores"
java -cp $GEMFIRE/lib/gemfire.jar:$cwd/../lib/DiskFileConverter.jar patch.CacheXmlTransform $cwd/GetDiskDir.xsl $CACHE_XML

awk '{print $1}' ${CACHE_XML}.xslt | sort -u > ${CACHE_XML}.sorted
rm -f iflist 2>/dev/null
for dir_in_xml in `cat ${CACHE_XML}.sorted`
do
  ls ${dir_in_xml}/*.if >> iflist 2>/dev/null
done

for f in `cat iflist`
do
  ds=`basename $f | cut -c7- | cut -f1 -d'.'`
  echo "verifying disk-store $ds: "
  $GEMFIRE/bin/gemfire validate-disk-store $ds `cat ${CACHE_XML}.sorted` 2>/dev/null
  if [ $? -eq 0 ]; then
    echo "    Verify $ds: OK"
    echo
  else
    echo "    Verify $ds: Fail"
    echo
  fi
done 
rm ${CACHE_XML}.xslt ${CACHE_XML}.sorted iflist snapshot.ser 2>/dev/null

if [ $ret -eq 0 ]; then
echo "Reminder: 1. The member using the converted disk files should be started "
echo "             before other members!"
echo "          2. Pre-6.5 persist files are supposed to be removed manually"
fi

