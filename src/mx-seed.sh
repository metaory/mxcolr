#!/usr/bin/env bash

SaveSeed () {
  Info " Save Temp Seed"  

  MXNAME="MXC_${MXC_V}"

  command -v bullshit &> /dev/null \
    && MXNAME="$(bullshit | cut -d' ' -f1 | cut -d'-' -f1)"

  PopulateFileWith "$M_SEED" 'FLUSH' \
    "export \${c}=\'\${!c}\'" \
    MXNAME SBG WBG EBG

  . "$M_SEED" && InfoDone "$M_SEED"
}

ReleaseSeed   () {
  cp -v "$M_SEED" "$O_SEED"
  . "$O_SEED" && InfoDone "$O_SEED"
}
