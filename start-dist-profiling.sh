#!/bin/sh -e

. ./machines.sh

if [ "$#" -ne 2 ]; then
    echo "Usage: sh start-dist-profiling.sh <run_name> <run_task>"
fi

run_name=$1
run_task=$2
curr_dir=`pwd`
target_dir=$curr_dir/$1-stats

mkdir ~/tmp-dist-profiling 
cp -r *-profiling.sh ~/tmp-dist-profiling/

./multitool.sh -s "rsync -avz $MASTER:~/tmp-dist-profiling/ ~/tmp-dist-profiling"
./multitool.sh -s "cd ~/tmp-dist-profiling; sh start-profiling.sh $1"
$run_task
./multitool.sh -s "cd ~/tmp-dist-profiling/; sh stop-profiling.sh"


mkdir $target_dir
./multitool.sh -s "rsync -avz ~/tmp-dist-profiling/$1-* $MASTER:/$target_dir/"
./multitool.sh -s 'rm -rf ~/tmp-dist-profiling'

for i in $target_dir/*
do
    if [ -d $i ]; then
	echo "Directory: $i"
	sh plot-stats.sh $i
    fi
done
