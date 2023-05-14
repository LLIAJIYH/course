# Bayram Tagiev
#
# Adding monitors to simulation

set windowvstime [open wvst w]
set qmon [$ns monitor-queue $node_(r0) $node_(r1) [open qm.out w]]
[$ns link $node_(r0) $node_(r1)] queue-sample-timeout

set redq [[$ns link $node_(r0) $node_(r1)] queue]
$redq set nonlinear_ 1
$redq set thresh_ 75
$redq set maxthresh_ 150
$redq set q_weight_ 0.002
$redq set linterm_ 10
# $redq set drop-tail_ true

set tchan_ [open all.q w]
$redq trace curq_
$redq trace ave_
$redq attach $tchan_
