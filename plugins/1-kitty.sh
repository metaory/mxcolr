#!/usr/bin/env bash
BS="$(GetPlugName)-theme.conf"
MXC_KITTY_TMP=/tmp/mxc/"$BS"
MXC_KITTY_OUT="${MXC_KITTY_OUT:-"$MXDIST/$BS"}"

cat <<  EOF > "$MXC_KITTY_TMP"
color20                $SBG
color21                $SFG
color30                $WBG
color31                $WFG
color40                $EBG
color41                $EFG

background             $XBG
foreground             $XFG
selection_background   $OBG
selection_foreground   $OFG
cursor_text_color      $WFX
cursor                 $WBX
EOF


PopulateFileWith "$MXC_KITTY_TMP" 'APPEND' \
  "\${c/C0/color} \${!c}" \
  C{00..09}
PopulateFileWith "$MXC_KITTY_TMP" 'APPEND' \
  "\${c/C/color} \${!c}" \
  C{10..15}


apply_kitty () {
  cp -v "$MXC_KITTY_TMP" "$MXC_KITTY_OUT"
  InfoDone "$MXC_KITTY_OUT"
}

# TODO for preview without tmux
# kitty @ "$KSOCK" set-colors "$KFLAG" "$MXKIT" 2>/dev/null

