#!/usr/bin/env bash

SaveSeed () {
  Info " Save Temp Seed"  

  MXNAME="$(bullshit | cut -d' ' -f1 | cut -d'-' -f1)" ; export MXNAME

  PopulateFileWith "$M_SEED" 'FLUSH' \
    "export \${c}=\'\${!c}\'" \
    MXNAME WBG SBG EBG

  . "$M_SEED" && InfoDone "$M_SEED"
}

ReleaseSeed   () {
  cp -v "$M_SEED" "$O_SEED"
  . "$O_SEED" && InfoDone "$O_SEED"
}
