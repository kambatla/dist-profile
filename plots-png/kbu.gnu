set title 'CPU Breakup
set grid
set terminal table
#set yrange [1:600000]
#set xrange [1191110400:1204156800]

set xtics("arch" 0, "block" 1, "fs" 2, "kernel" 3, "lib" 4, "mm" 5, "net" 6, "other" 7) 
set xtics rotate by -45

set autoscale
set ylabel '%CPU'
set xlabel 'Type'
set pointsize 0.2
set key top center horizontal
#set log y
set style line 10 lt 1 lw 4 pt 10 ps 2.0
set style line 11 lt 3 lw 4 pt 10 ps 2.0
set style line 12 lt 5 lw 4 pt 10 ps 2.0
set style line 13 lt 7 lw 4 pt 10 ps 2.0

plot 'kernel-breakup' using 0:2 t '' with  boxes

set terminal png noenhanced 12
set output 'cpubreakup.png'
replot

