dir=$1-`hostname`
killall -9 vmstat
killall -9 ifstat
date +'%s' > $dir/stop-date
cat $dir/start-date >> $dir/stop-date
