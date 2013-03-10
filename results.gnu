set title 'Results'
set grid
set autoscale
set ylabel 'Time in seconds'
set y2label 'CPU waiting'
set y2range [0:100]
set yrange [0:*]

set xtics ("Disk-11" 0, "Disk-6" 1, "Flash" 2, "Hbrd-11" 3, "Hbrd-6" 4)
set ytics nomirror
set y2tics

set key top right vertical
set size ratio 0.75
set offset 0,0,200,0

set style data histogram
set style histogram cluster gap 1
set style fill solid border -1
set boxwidth 0.9

plot 'results' using 2 t 'Runtime (secs)'
replot 'results' using 3 t 'Median CPU-wait' axes x1y2
replot 'results' using 4 t 'Max CPU-wait' axes x1y2

set terminal png noenhanced 12
set output 'results.png'
replot

