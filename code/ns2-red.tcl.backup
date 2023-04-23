set ns [new Simulator]

set nf [open out.nam w]
$ns namtrace-all $nf

set node_(r0) [$ns node]
set node_(r1) [$ns node]
$node_(r0) color "red"
$node_(r1) color "red"
$node_(r0) label "RED"

set N 20

for {set i 0} {$i < $N} {incr i} {
	set node_(s$i) [$ns node]
	$node_(s$i) color "blue"
	$node_(s$i) label "ftp"
	$ns duplex-link $node_(s$i) $node_(r0) 100Mb 20ms DropTail

	set node_(s[expr $N + $i]) [$ns node]
	$ns duplex-link $node_(s[expr $N + $i]) $node_(r1) 100Mb 20ms DropTail
}

$ns simplex-link $node_(r0) $node_(r1) 20Mb 15ms RED
$ns simplex-link $node_(r1) $node_(r0) 15Mb 20ms DropTail

$ns queue-limit $node_(r0) $node_(r1) 300


for {set t 0} {$t < $N} {incr t} {
	$ns color $t green
	set tcp($t) [$ns create-connection TCP/Reno $node_(s$t) TCPSink $node_(s[expr $N + $t]) $t]
	$tcp($t) set window_ 32
	$tcp($t) set maxcwnd_ 32
	$tcp($t) set packetSize_ 500
	set ftp($t) [$tcp($t) attach-source FTP]
}

$ns simplex-link-op $node_(r0) $node_(r1) orient right
$ns simplex-link-op $node_(r1) $node_(r0) orient left
$ns simplex-link-op $node_(r0) $node_(r1) queuePos 0
$ns simplex-link-op $node_(r1) $node_(r0) queuePos 0


for {set m 0} {$m < $N} {incr m} {
	$ns duplex-link-op $node_(s$m) $node_(r0) orient right
	$ns duplex-link-op $node_(s[expr $N + $m]) $node_(r1) orient left 
}

set windowVsTime [open WvsT w]
set qmon [$ns monitor-queue $node_(r0) $node_(r1) [open qm.out w]]
[$ns link $node_(r0) $node_(r1)] queue-sample-timeout

set redq [[$ns link $node_(r0) $node_(r1)] queue]
$redq set qlim_ 75 150
#$redq set thresh_ 75
#$redq set maxthresh_ 150
$redq set q_weight_ 0.002
$redq set linterm_ 0.1
$redq set drop-tail_ true
set tchan_ [open all.q w]
$redq trace curq_
$redq trace ave_
$redq attach $tchan_


for {set r 0} {$r < $N} {incr r} {
	$ns at 0.0 "$ftp($r) start"
	$ns at 1.0 "plotWindow $tcp($r) $windowVsTime"
	$ns at 20.0 "$ftp($r) stop"
}

$ns at 21.0 "finish"

proc plotWindow {tcpSource file} {
   global ns
   set time 0.01
   set now [$ns now]
   set cwnd [$tcpSource set cwnd_]
   puts $file "$now $cwnd"
   $ns at [expr $now+$time] "plotWindow $tcpSource $file"
}

proc finish {} {
   global ns nf
   $ns flush-trace
   close $nf
   global tchan_
   set awkCode {
      {
	 if ($1 == "Q" && NF>2) {
	    print $2, $3 >> "temp.q";
	    set end $2
	 }
	 else if ($1 == "a" && NF>2)
	 print $2, $3 >> "temp.a";
      }
   }

   set f [open temp.queue w]
   puts $f "TitleText: RED"
   puts $f "Device: Postscript"

   if { [info exists tchan_] } {
      close $tchan_
   }

   exec rm -f temp.q temp.a
   exec touch temp.a temp.q

   exec awk $awkCode all.q

   puts $f \"queue
   exec cat temp.q >@ $f
   puts $f \n\"ave_queue
   exec cat temp.a >@ $f
   close $f

   exec xgraph -bb -tk -x time -t "TCPRenoCWND" WvsT &
   exec xgraph -bb -tk -x time -y queue temp.queue &
   exec nam out.nam &
   exit 0
}

$ns run

