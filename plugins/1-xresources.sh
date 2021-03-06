#!/usr/bin/env bash

BS="$(GetPlugName)-theme.xdefaults"
# MXC_XRS_TMP=/tmp/mxc/"$BS"
MXC_XRS_OUT="${MXC_XRS_OUT:-"$MXDIST/$BS"}"

# $(get_header '!')
# cat <<   EOF | tr '[:upper:]' '[:lower:]' > "$MXC_XRS_TMP"
# $MXNAME
# *.background:           $XBG
# *.foreground:           $XFG
# *.selection_background: $OBG
# *.selection_foreground: $OFG
# *.cursor_text_color:    $WFX
# *.cursor:               $WBX
# EOF

# shellcheck disable=SC2016
# PopulateFileWith "$MXC_XRS_TMP" 'APPEND' \
#   '*.${c/C0/color}: ${!c}' \
#   C{00..09}
# shellcheck disable=SC2016
# PopulateFileWith "$MXC_XRS_TMP" 'APPEND' \
#   '*.${c/C/color}: ${!c}' \
#   C{10..15}
# shellcheck disable=SC2046
# shellcheck disable=SC2016
# PopulateFileWith "$MXC_XRS_TMP" 'APPEND' \
#   '*.${c,,}: ${!c}' \
#   "${MX_VARS[@]}"

# Info "$MXC_XRS_TMP"

apply_xresources() {
  if ! grep "mxc" "$HOME"/.Xresources; then 
    InfoWarn "${MXC_XRS_OUT} is not included in $HOME/.Xresources"
    # Info 'appent include?'; PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
    InfoWarn "add this to your $HOME/.Xresources "
    echo "#include $MXC_XRS_OUT"; echo
    # echo "#include '~/.config/mxc/mx-xrs.xdefaults'" >> "$HOME"/.Xresources; InfoDone 'added'
  fi

  # cp -v "$MXC_XRS_TMP" "$MXC_XRS_OUT"
  xrdb "$HOME/.Xresources"; InfoDone "refreshed xrdb with $HOME/.Xresources"

  Info "$MXC_XRS_OUT"
}
