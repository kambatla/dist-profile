set title 'Disk I/O'
set grid
set autoscale
set ylabel 'MBps'
set xlabel 'Time'
set pointsize 0.2
set key top center horizontal
#set log y
set style line 10 lt 1 lw 4 pt 10 ps 2.0
set style line 11 lt 3 lw 4 pt 10 ps 2.0
set style line 12 lt 5 lw 4 pt 10 ps 2.0
set style line 13 lt 7 lw 4 pt 10 ps 2.0


plot 'vmstat-copy' using 0:(($9 * 4)/10240) t 'Block In' with  lines linestyle 10
replot 'vmstat-copy' using 0:(($10 * 4)/10240) t 'Block Out' with  lines linestyle 11

set terminal png noenhanced 12
set output 'disk.png'
replot

