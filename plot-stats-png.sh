#!/bin/bash -e

data_dir=$1

plotting_dir=`pwd`
cd $data_dir
	
# Remove extraneous lines
grep -v [a-zA-Z] vmstat > vmstat-copy
grep -v [a-zA-Z] ifstat > ifstat-copy
	
# Now plot each of those files
cp $plotting_dir/plots-png/cpu.gnu ./
gnuplot cpu.gnu > /dev/null

cp $plotting_dir/plots-png/mem.gnu ./
gnuplot mem.gnu > /dev/null

cp $plotting_dir/plots-png/disk.gnu ./
gnuplot disk.gnu > /dev/null

cp $plotting_dir/plots-png/netio.gnu ./
gnuplot netio.gnu > /dev/null

rm *.gnu

cd $plotting_dir

