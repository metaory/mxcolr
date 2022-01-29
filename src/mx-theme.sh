#!/usr/bin/env bash

SaveTheme () {
  PopulateFileWith "$MTHEME"  'FLUSH' \
    "export \${c}=\'\${!c}\'" \
    MXNAME MXC_V "${MX_VARS[@]}" "${MX_TERM[@]}" "${MX_HLES[@]}"

  . "$MTHEME" && InfoDone "$MTHEME"
}

ReleaseTheme  () {
  cp -v "$MTHEME" "$OTHEME"
  . "$OTHEME" && InfoDone "$OTHEME"
}

