#!/bin/bash
echo "How many copies?"
read total
echo "Ok, making $total copies"
for ((i=1 ; i <= total ; i++))
do
  cp 2015-07-26-LAX-JFK.json 2015-07-26-LAX-JFK$i.json
done
export size=`du -h`;
echo "$i files created for a total size of $size"
echo "Enjoy your files!"
