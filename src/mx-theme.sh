#!/usr/bin/env bash

PopulateFileWith () {
  local file="$1"   ; shift
  local operation="$1" ; shift
  local format="$1" ; shift

  InfoWarn "${operation^}ing ${file##*/} with ${#} keys"; mlg " ==> $*"

  if [[ "$operation" == 'FLUSH'* ]]; then
    get_header "$(cut -d':' -f2 -s <<< "$operation")" > "$file"
    echo  >> "$file"
  fi

  while [ "$1" ]; do
    local c="$1"; local hl="HL$1"; shift
    eval echo "$format" >> "$file"
  done

  printf ' ==> '; file "$file"
}

####################################################

SaveTheme () {
  PopulateFileWith "$MTHEME"  'FLUSH' \
    "export \${c}=\'\${!c}\'" \
    MXNAME MXC_V "${MX_VARS[@]}" "${MX_TERM[@]}"

  . "$MTHEME" && InfoDone "$MTHEME"
}

ReleaseTheme  () {
  cp -v "$MTHEME" "$OTHEME"
  . "$OTHEME" && InfoDone "$OTHEME"
}

