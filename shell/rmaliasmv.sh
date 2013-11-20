#!/bin/bash
                         
if [ ! -d ~/trash ]; then
    mkdir -p ~/trash      
fi

id=`date +%Y%m%d%H%M%S`
argc=$#

for ((i=1; i<=${argc}; ++i))
do
    filename=`echo "$1" | awk -F "/" '{if($NF=="")print $(NF-1); else print $NF;}'`
    mv $1 ~/trash/${filename}.${id}
    shift
done

