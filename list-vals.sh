#! /bin/bash

COUNTER=1
OUTPUT=""
LIST=""

while [ 1 -eq 1 ]; do
	VALS=$(terrad q staking validators --page $COUNTER | jq -r '.validators')
	NUM=$(echo $VALS | jq -r 'length')
	if [ $NUM -eq 0 ]; then
		break
	fi
	COUNTER=$(( $COUNTER + 1 ))
	LIST="$LIST""$VALS"
done

echo $LIST |  jq -r 'flatten(1) | .[] | select(.status == "BOND_STATUS_BONDED") | .description.moniker '
