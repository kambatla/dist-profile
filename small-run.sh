#!/bin/bash -xe

if [ "$#" -ne 1 ]; then
    echo "Usage: sh run.sh <run_name>"
    exit 0
fi

# 1. Teragen
sh start-dist-profiling.sh teragen-$1 '/home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/bin/hadoop jar /home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/hadoop-examples-2.0.0-mr1-cdh4.2.0.jar teragen -Dmapred.map.tasks=480 -Dmapred.reduce.tasks=240 2400000000 teragen-out'

# 2. Terasort 
sh start-dist-profiling.sh terasort-$1 '/home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/bin/hadoop jar /home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/hadoop-examples-2.0.0-mr1-cdh4.2.0.jar terasort -Dmapred.map.tasks=480 -Dmapred.reduce.tasks=240 teragen-out terasort-out'

# 3. Terasort compress
sh start-dist-profiling.sh terasort-compress-$1 '/home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/bin/hadoop jar /home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/hadoop-examples-2.0.0-mr1-cdh4.2.0.jar terasort -Dmapred.map.tasks=480 -Dmapred.reduce.tasks=240 -Dmapred.compress.map.output=true -Dmapred.map.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec teragen-out terasort-compress-out'

/home/kasha/h/hadoop-2.0.0-cdh4.2.0/bin/hadoop fs -rmr teragen-out
/home/kasha/h/hadoop-2.0.0-cdh4.2.0/bin/hadoop fs -rmr terasort-compress-out

# 4. Teravalidate 
sh start-dist-profiling.sh teravalidate-$1 '/home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/bin/hadoop jar /home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/hadoop-examples-2.0.0-mr1-cdh4.2.0.jar teravalidate -Dmapred.map.tasks=480 -Dmapred.reduce.tasks=240 terasort-out teravalidate-out'

/home/kasha/h/hadoop-2.0.0-cdh4.2.0/bin/hadoop fs -rmr teravalidate-out

# 5. Wordcount
sh start-dist-profiling.sh wordcount-$1 '/home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/bin/hadoop jar /home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/hadoop-examples-2.0.0-mr1-cdh4.2.0.jar wordcount -Dmapred.map.tasks=480 -Dmapred.reduce.tasks=240 terasort-out wc-out'

/home/kasha/h/hadoop-2.0.0-cdh4.2.0/bin/hadoop fs -rmr wc-out

# 6. Compressed wordcount
sh start-dist-profiling.sh wordcount-compress-$1 '/home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/bin/hadoop jar /home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/hadoop-examples-2.0.0-mr1-cdh4.2.0.jar wordcount -Dmapred.map.tasks=480 -Dmapred.reduce.tasks=240 -Dmapred.compress.map.output=true -Dmapred.map.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec terasort-out wc-compress-out'

/home/kasha/h/hadoop-2.0.0-cdh4.2.0/bin/hadoop fs -rmr wc-compress-out

# 7. Shuffle
sh start-dist-profiling.sh shuffle-$1 '/home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/bin/hadoop jar /home/kasha/jars/macrobenchmarks-1.0-SNAPSHOT-jar-with-dependencies.jar com.cloudera.mb.ShuffleText -Dmapred.map.tasks=480 -Dmapred.reduce.tasks=240 2400000000 shuffle-out'

/home/kasha/h/hadoop-2.0.0-cdh4.2.0/bin/hadoop fs -rmr shuffle-out

# 8. Compressed shuffle
sh start-dist-profiling.sh shuffle-compress-$1 '/home/kasha/h/hadoop-2.0.0-mr1-cdh4.2.0/bin/hadoop jar /home/kasha/jars/macrobenchmarks-1.0-SNAPSHOT-jar-with-dependencies.jar com.cloudera.mb.ShuffleText -Dmapred.map.tasks=480 -Dmapred.reduce.tasks=240 -Dmapred.compress.map.output=true -Dmapred.map.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec 2400000000 shuffle-compress-out'

/home/kasha/h/hadoop-2.0.0-cdh4.2.0/bin/hadoop fs -rmr shuffle-compress-out
