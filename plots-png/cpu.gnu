set title 'CPU'
set grid
set autoscale
set ylabel '% CPU'
set xlabel 'Time'
set pointsize 0.2
set key top center horizontal
#set log y
set style line 10 lt 1 lw 2 pt 10 ps 1.0
set style line 11 lt 2 lw 2 pt 11 ps 1.0
set style line 12 lt 3 lw 2 pt 12 ps 1.0
set style line 13 lt 4 lw 2 pt 13 ps 1.0


plot 'vmstat-copy' using 0:13 t 'user' with  lines linestyle 10
replot 'vmstat-copy' using 0:($13+$14) t 'system' with  lines linestyle 11
replot 'vmstat-copy' using 0:($13+$14+$16) t 'waiting' with  lines linestyle 13
replot 'vmstat-copy' using 0:($13+$14+$15+$16) t 'idle' with  lines linestyle 12

set terminal png noenhanced 12
set output 'cpu.png'
replot

