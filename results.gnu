set title 'Results'
set grid
set autoscale
set ylabel 'Time in seconds'
set y2label 'CPU waiting'
set y2range [0:100]

set xtics ("Disk-11" 0, "Disk-6" 1, "Flash" 2, "Hybrid-11" 3, "Hybrid-6" 4)
set ytics nomirror
set y2tics

set pointsize 0.2
set key top right vertical

set style line 10 lt 1 lw 2 pt 10 ps 1.0
set style line 11 lt 2 lw 2 pt 11 ps 1.0
set style line 12 lt 3 lw 2 pt 12 ps 1.0
set style line 13 lt 4 lw 2 pt 13 ps 1.0

plot 'results' using 0:2 t 'Runtime (seconds)' with  lines linestyle 10
replot 'results' using 0:3 t 'Median CPU waiting' with  lines linestyle 11 axes x1y2
replot 'results' using 0:4 t 'Max CPU waiting' with  lines linestyle 13 axes x1y2

set terminal png noenhanced 12
set output 'results.png'
replot

