#!/bin/bash -e

data_dir=$1

plotting_dir=`pwd`
cd $data_dir
	
# Remove extraneous lines
cp $plotting_dir/results.gnu ./
gnuplot results.gnu > /dev/null

rm *.gnu

cd $plotting_dir

