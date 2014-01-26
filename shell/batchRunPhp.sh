#!/bin/bash
#
# 这个脚本的作用是将php中一个大循环变成一个小循环，防止php中的内存泄露问题造成整个服务器死掉
#
if [ $# -ne 2 ];then
    echo "Usage: batchRunPhp.sh startId endId"
    exit 1
fi

startId=$1
endId=$2

for ((curId=startId; curId <= endId;));
do
    ((tmpEndId = curId+100000-1))
    echo $curId" "$tmpEndId
#/usr/bin/php phpScript.php $curId $tmpEndId
    ((curId = tmpEndId+1))
done
