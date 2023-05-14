#!/usr/bin/gnuplot -persist
set xrange [0:20]

set terminal postscript eps
set output "queues.eps"
set xlabel "Time (s)"
set ylabel "Queue Length"
set title "ARED Queue"
plot "temp.q" with lines linestyle 1 lt 1 lw 2 title "Queue length"

set terminal postscript eps
set output "ave_queues.eps"
set xlabel "Time (s)"
set ylabel "Queue Length"
set title "ARED Queue"
plot "temp.a" with lines linestyle 2 lt 3 lw 2 title "Average queue length"

set terminal postscript eps
set output "TCP.eps"
set xlabel "Time (s)"
set ylabel "Window size"
set title "TCPVsWindow"
plot "wvst" with lines linestyle 1 lt 1 lw 2 title "WvsT"
