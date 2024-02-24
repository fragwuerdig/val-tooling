#! /bin/bash

set -e

function usage() {

	echo "Usage:"
	echo "vote.sh [prop-id] [vote-option] <reason> [voting-key]" 

}

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
DEFAULTPATH=${SCRIPTPATH}/DEFAULTS
. ${DEFAULTPATH}


if [ $# -eq 4 ]; then
	ID=$1
	OPTION=$2
	NOTE="$3"
	KEY=$4
elif [ $# -eq 3 ]; then
        ID=$1
	OPTION=$2
	NOTE=""
	KEY=$3
else
	usage
	exit -1
fi

CMD=(terrad tx gov vote "$ID" "$OPTION")

if [ -n "$NOTE" ]; then
    CMD+=("--note" "$NOTE")
fi

CMD+=("--gas" "auto" "--gas-prices" "29uluna" "--gas-adjustment" "2.3" "--from" "$KEY")

echo "${CMD[@]}"
"${CMD[@]}"

