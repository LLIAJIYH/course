set ns [new Simulator]

set tr [new out.tr w]
$ns trace-all $tf

set lambda 30.0
set mu 33.0

set qsize 100000
set duration 2000.0

set n1 [$ns node]
set n2 [$ns node]

set link [$ns simplex-link $n1 $n2 100kb 0ms DropTail]
$ns queue-limit $n1 $n2 $qsize

set InterArrivalTime [new RandomVariable/Exponential]
$InterArrivalTime set avg_ [expr 1/$lambda]
set pktSize [new RandomVariable/Exponential]
$pktSize set avg_ [expr 100000.0/(0.8*$mu)]



