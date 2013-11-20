#!/bin/bash
cat $1 > temp
cat $2 >> temp
cat $2 >> temp
sort -T ./ temp | uniq -c | awk '{
if (1 == $1) {
	print $2 >> "oldonly2"
}
else if(2 == $1) {
	print $2 >> "newonly2"
}
else if(3 == $1) {
	print $2 >> "common2"
}
}'
