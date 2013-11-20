#!/bin/bash
if [ $# -ne 2 ];
then
	echo "Usage: $0 filename select_num ";
	exit 1
fi

filename=$1
select_num=$2
total_num=`cat $filename | wc -l`
ratio=`awk 'BEGIN{printf "%.6f",('$select_num'/'$total_num')}'`
awk -v threshold="$ratio" ' \
BEGIN{
	srand();
}
{
	if( rand() < threshold ) {
		print $0;
	}
}' $filename
