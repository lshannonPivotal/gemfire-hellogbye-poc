#!/bin/bash
echo "How many to delete?"
read total
for ((i=1 ; i <= total ; i++))
do
  rm 2015-07-26-LAX-JFK$i.json
done
echo "Done!"
echo "Enjoy the extra file space!"
