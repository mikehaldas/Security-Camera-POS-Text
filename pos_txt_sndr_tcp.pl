#!/usr/local/bin/perl

# pos_txt_sndr_tcp.pl				
# Sample POS Text Integration for Viewtron Secuity Camera Systems.
# This example uses TCP/IP and to send POS transaction text. 
# Viewtron IP camera NVRs and BNC camera DVRs both support
# the ability to overlay point of sale / cash register text
# over recorded security camera footage.
# CCTV Camera Pros assists POS manufacturers with integrating their systems
# with Viewtron recorders. Visit this page for more info.
# https://www.cctvcamerapros.com/CCTV-POS-Text-s/1520.htm
# https://www.Viewtron.com
# Developer and POC Mike Haldas
# mike@viewtron.com

use strict;
use warnings;
use IO::Socket::INET;

$| = 1; # auto-flush
my $dvr_ip = '192.168.0.54';
my $pos_port = 9036;

my $msg = <<'END_MESSAGE';
********* Begin Transaction *********
5 Gatorade             12.00
1 Chocolate Bar         3.75
4 Peanuts               2.00	

Total                  23.75

PAID with Bitcoin
********* End Transaction *********
END_MESSAGE

my $socket = new IO::Socket::INET (
PeerHost => $dvr_ip,
PeerPort => $pos_port,
Proto => 'tcp',
);

if($socket) {
my $size = $socket->send($msg);
print "Sent: $size\n";
$socket->close();
}
