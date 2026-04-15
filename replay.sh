#!/bin/bash
#


set -euo pipefail

IF=${1:?ethernet device not given}
PCAP=${2:?pcap or pcap.gz argument not given}

cleanup() {
	rv=$?
	[ -f "/tmp/$$.pcap" ] && rm -f "/tmp/$$.pcap"
	exit $rv
}

if [ ! -s "${PCAP}" ] 
then
	echo "$0: ${PCAP} is not a file"
	exit 1
fi

if [[ ${PCAP} == *.gz ]]
then
	gunzip < "${PCAP}" > "/tmp/$$.pcap"
	trap "cleanup" EXIT
	PCAP="/tmp/$$.pcap"
fi

OPTIONS=""
if [[ $(uname) == Linux ]]
then
  OPTIONS="-T select"
fi

tcpreplay ${OPTIONS} -l 0 -i "${IF}" "$PCAP"

