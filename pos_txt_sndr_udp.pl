#!/usr/local/bin/perl 

# pos_txt_sndr_udp.pl			
# Sample POS Text Integration for Viewtron Secuity Camera Systems.
# This example uses UDP and XML to send POS transaction data 
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
use IO::Socket::Multicast;

use constant DESTINATION => '230.0.0.1:4050';

my $msg = <<'END_MESSAGE';
<POSEventMessage>
<storeCode>2019</storeCode>
<till>2</till>
<txnNumber>521</txnNumber>
<operatorCode name="Mike">
<value>5047</value>
</operatorCode>
<sequenceNumber>0</sequenceNumber>
<date>20230818</date>
<time>18060100</time>
<event type="ITEM SALE">
<amount>14.50</amount>
<departmentCode name="SODA &amp; Juice">
<value>045</value>
</departmentCode>
<description>Diet Coca Cola 16oz</description>
<quantity>1</quantity>
<sku>70001</sku>
<unitPrice>1.99</unitPrice>
</event>
</POSEventMessage>
END_MESSAGE

# create a new UDP socket 
my $s = IO::Socket::Multicast->new(Proto=>'udp',PeerAddr=>DESTINATION);

# Multicast message to DVR / NVR
$s->send($msg) || die "Could not send: $!\n";
