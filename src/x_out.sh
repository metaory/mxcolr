#!/usr/bin/env bash

mlg 'XP_MAIN'

# :>"$MTHEME"
# rm "$MTHEME" &>/dev/null
PopulateFileWith () {
  local file="$1"   ; shift
  local operation="$1" ; shift
  local format="$1" ; shift

  Info 2 "${operation^}ing ${file##*/} with ${#} keys"; mlg " ==> $*"

  # cp -v "$file" "${file%/*}/${file##*/}_old" 2>/dev/null || true

  [[ "$operation" == 'FLUSH' ]] && :>"$file"

  while [ "$1" ]; do
    local c="$1"; shift
    eval echo "$format" >> "$file"
  done

  echo; printf ' ==> '
  file "$file" && InfoDone "$file"
}

####################################################

SaveTheme () {
  # shellcheck disable=SC2046
  PopulateFileWith "$MTHEME"  'FLUSH' \
    "export \${c}=\'\${!c}\'" \
    MXNAME MXC_V $(eval echo \$\{MX_Z{C,X,M,K,L}\[\@\]\})

  InfoDone
}

ReleaseTheme  () {
  Info " Release Theme" 0

  cp -v "$MTHEME" "$OTHEME"
  . "$OTHEME"
  InfoDone "$OTHEME"
}

