#!/usr/bin/env bash

MXNAME="$(bullshit | cut -d' ' -f1 | cut -d'-' -f1)" ; export MXNAME

cat <<  EOF > "$M_SEED"
export MXNAME="$MXNAME"

##---SOF-MXORG--#
export WBG="$WBG"
export SBG="$SBG"
export EBG="$EBG"
##---EOF-MXORG--#
EOF

