#!/bin/bash

find . -name '*.pcap*.gz' | while read i
do
   gunzip < "$i" > /tmp/o.pcap
  tcpdump -r /tmp/o.pcap -w /tmp/t.pcap port 5800
  cp /tmp/total.pcap /tmp/t2.pcap || cp /tmp/t.pcap /tmp/t2.pcap
mergecap -a /tmp/t.pcap /tmp/t2.pcap -w /tmp/total.pcap
done

