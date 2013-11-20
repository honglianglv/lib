#!/bin/bash
#this file get the links of site in site.list from all the linkbase


HADOOP="/home/rd/hadoop-client/hadoop/bin/hadoop"
INPUT="-input /user/rd/lvhongliang/weighturl/input/weight_data_name_only"
OUTPUT_BASE="/user/rd/lvhongliang/weighturl"
OUTPUT="${OUTPUT_BASE}/marked_480000/"

${HADOOP} dfs -test -d ${OUTPUT_BASE}
if [ $? -ne 0 ]; then
    ${HADOOP} dfs -mkdir ${OUTPUT_BASE}
fi

if [ 0 -eq 0 ];then
    ${HADOOP} dfs -rmr ${OUTPUT}
    ${HADOOP} streaming \
        -mapper "sh -x map.sh" \
        -reducer "sh -x reduce.sh" \
        ${INPUT} \
        -file "map.sh" \
        -file "reduce.sh" \
        -file "site480000.list" \
        -file "dlb_env.sh" \
        -file "hadoop-site.xml" \
        -output "${OUTPUT}" \
        -jobconf mapred.job.name="get_marked_weight-lvhongliang" \
        -jobconf mapred.reduce.tasks=1000 \
        -jobconf mapred.job.map.capacity=15 \
        -jobconf mapred.job.reduce.capacity=15 \
        -jobconf mapred.compress.map.output=false \
        -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner \
        -inputformat org.apache.hadoop.mapred.lib.NLineInputFormat \
        -jobconf stream.map.output.field.separator=" "\
        -jobconf stream.num.map.output.key.fields=1 \
        -jobconf map.output.key.field.separator="/" \
        -jobconf num.key.fields.for.partition=1 \
        -jobconf mapred.job.priority=NORMAL \
        -jobconf mapred.reduce.slowstart.completed.maps=0.2 \
        -jobconf stream.memory.limit=800 
fi

#    -jobconf stream.reduce.output.field.separator="/" \
#    -jobconf stream.num.reduce.output.key.fields=1 \
