#/bin/bash

for i in 24 48 week
do

TEMP=/tmp/last$i.csv
OUT=/tmp/output$i.png

gnuplot << eor
set terminal pngcairo size 1800,900 enhanced font "Verdana,12"
set output "$OUT"
set style data linespoints
set datafile separator ","
set datafile separator ","
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%d/%H"
set title "Last $i" font ",14"
set xlabel "timestamp"
set ylabel "temperature"
set style line 1 lc rgb '#e41a1c' pt 1 ps 1 lt 1 lw 2 # --- red
set style line 2 lc rgb '#377eb8' pt 6 ps 1 lt 1 lw 2 # --- blue
set style line 3 lc rgb '#4daf4a' pt 6 ps 1 lt 1 lw 2 # --- green
set style line 4 lc rgb '#984ea3' pt 6 ps 1 lt 1 lw 2 # --- violet
set style line 5 lc rgb '#ff7f00' pt 6 ps 1 lt 1 lw 2 # --- orange
set style line 6 lc rgb '#ffff33' pt 6 ps 1 lt 1 lw 2 # --- yellow
set style line 7 lc rgb '#a65628' pt 6 ps 1 lt 1 lw 2 # --- brown
set style line 8 lc rgb '#f781bf' pt 6 ps 1 lt 1 lw 2 # --- pink
set style line 11 lc rgb '#808080' lt 1
set style line 12 lc rgb '#808080' lt 0 lw 1
set border 3 back ls 11
set tics nomirror
set grid back ls 12
set key box linestyle 11
plot "$TEMP" using 1:2 title "roof F1" with lines linestyle 1,\
     "$TEMP" using 1:4 title "tank bottom F3" with lines linestyle 2,\
     "$TEMP" using 1:6 title "tank top F6" with lines linestyle 3,\
     "$TEMP" using 1:3 title "F2" with lines linestyle 8, \
     "$TEMP" using 1:5 title "F4" with lines linestyle 7, \
     "$TEMP" using 1:7 title "pump/3 %" with lines  linestyle 11, \
     85 title "" linetype -1, \
     90 title "" linetype -1, \
     95 title "" linetype -1, \
     110  title "" linetype -1
eor

done
