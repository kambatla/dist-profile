dir=$1-`hostname`

mkdir -p $dir
vmstat 10 > $dir/vmstat &
ifstat 10 > $dir/ifstat &
