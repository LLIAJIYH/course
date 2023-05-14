#!/usr/bin/gnuplot -persist
set xrange [0:20]

set terminal postscript eps
set output "queues.eps"
set xlabel "Time (s)"
set ylabel "Queue Length"
set title "Queue comparison"
set style line 1 linetype 1 linewidth 1
set style line 2 linetype 2 linewidth 1
plot "nlred.temp.q" with lines title "NLRED", "re-ared.temp.q" with lines title "Re-ARED"

set terminal postscript eps
set output "ave_queues.eps"
set xlabel "Time (s)"
set ylabel "Average queue Length"
set title "Queue comparison"
set style line 1 linetype 1 linewidth 1
set style line 2 linetype 2 linewidth 1
plot "nlred.temp.a" with lines title "NLRED", "re-ared.temp.a" with lines title "Re-ARED"

set terminal postscript eps
set output "TCP.eps"
set xlabel "Time (s)"
set ylabel "Window size"
set title "TCPVsWindow"
set style line 1 linetype 1 linewidth 1
set style line 2 linetype 2 linewidth 1
plot "nlred.wvst" with lines title "NLRED", "re-ared.wvst" with lines title "Re-ARED"
