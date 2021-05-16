#!/usr/bin/env bash

get_ansi () {
  local c="$1"; local x;
  x=$(pastel format ansi-8bit "${!c}" | cut -d";" -f3-)
  echo "${x::(-1)}"
}

gen_ansi () {
  for x in "${MX_VARS[@]}"; do
    declare -g "T$x=$(get_ansi "$x")"
  done
}

