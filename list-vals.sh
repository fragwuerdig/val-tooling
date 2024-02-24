#! /bin/bash


COUNTER=0
OUTPUT="dummy"
LIST=""

while [ ! -z "$OUTPUT" ]; do
	OUTPUT=$(terrad q staking validators --page $COUNTER | jq -r '.validators[] | select(.status == "BOND_STATUS_BONDED") | .description')
	COUNTER=$(( $COUNTER + 1 ))
	LIST=$LIST$OUTPUT
done

echo $LIST | jq -r

