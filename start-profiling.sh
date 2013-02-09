dir=$1

mkdir -p $dir
vmstat 10 > $dir/vmstat &
ifstat 10 > $dir/ifstat &
