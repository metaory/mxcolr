#!/usr/bin/env bash

PopulateFileWith () {
  local file="$1"   ; shift
  local operation="$1" ; shift
  local format="$1" ; shift

  Info 2 "${operation^}ing ${file##*/} with ${#} keys"; mlg " ==> $*"

  if [[ "$operation" == 'FLUSH'* ]]; then
    get_header "$(cut -d':' -f2 -s <<< "$operation")" > "$file"
    echo  >> "$file"
  fi

  while [ "$1" ]; do
    local c="$1"; shift
    eval echo "$format" >> "$file"
  done

  echo; printf ' ==> '
  file "$file" && InfoDone "$file"
}

####################################################

SaveTheme () {
  PopulateFileWith "$MTHEME"  'FLUSH' \
    "export \${c}=\'\${!c}\'" \
    MXNAME MXC_V "${MX_VARS[@]}" "${MX_TERM[@]}"
  InfoDone
}

ReleaseTheme  () {
  Info " Release Theme" 0

  cp -v "$MTHEME" "$OTHEME"
  . "$OTHEME"
  InfoDone "$OTHEME"
}

