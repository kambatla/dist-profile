set title 'Memory'
set grid
set autoscale
set ylabel 'Memory'
set xlabel 'Time'
set pointsize 0.2
set key right bottom
#set log y
set style line 10 lt 1 lw 2 pt 10 ps 1.0
set style line 11 lt 2 lw 2 pt 11 ps 1.0
set style line 12 lt 3 lw 2 pt 12 ps 1.0
set style line 13 lt 4 lw 2 pt 13 ps 1.0


plot 'vmstat-copy' using 0:3 t 'swpd' with  lines linestyle 10
replot 'vmstat-copy' using 0:4 t 'free' with  lines linestyle 11
replot 'vmstat-copy' using 0:5 t 'buff' with  lines linestyle 13
replot 'vmstat-copy' using 0:6 t 'cache' with  lines linestyle 12

set terminal postscript eps color noenhanced defaultplex "Helvetica" 18
set output 'mem.eps'
replot

