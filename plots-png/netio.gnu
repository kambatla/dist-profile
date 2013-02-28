set title 'Network I/O'
set grid

set autoscale
set ylabel 'KB/s'
set xlabel 'Time'
set pointsize 0.2
set key top center horizontal
#set log y
set style line 10 lt 1 lw 2 pt 10 ps 2.0
set style line 11 lt 2 lw 2 pt 10 ps 2.0
set style line 12 lt 3 lw 2 pt 10 ps 2.0
set style line 13 lt 4 lw 2 pt 10 ps 2.0


plot 'ifstat-copy' using 0:1 t 'In' with  lines linestyle 10
replot 'ifstat-copy' using 0:2 t 'Out' with  lines linestyle 11

set terminal png noenhanced 12
set output 'netio.png'
replot

