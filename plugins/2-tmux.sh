#!/usr/bin/env bash
# #################

# ## >>> ##########
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\  

temp="${MXTEMP}"/tmux.mx
dist="${MXDIST}"/tmux.mx

cat <<  EOF > "$temp"
WBG="${WBG}"
WFG="${WFG}"
EBG="${EBG}"
EFG="${EFG}"
SBG="${SBG}"
SFG="${SFG}"
OBG="${OBG}"
OFG="${OFG}"
XBG="${XBG}"
XFG="${XFG}"
DK0="${DK0}"
DK1="${DK1}"
DK2="${DK2}"
DK3="${DK3}"
DK4="${DK4}"
DK5="${DK5}"
DK6="${DK6}"
DK7="${DK7}"
EOF

[ "$TMUX" ] && tmux run-shell "tmux source-file $temp"
[ "$TMUX" ] && tmux run-shell "tmux source-file $M_THEME"

apply_tmux () {
  local TSOCK=''; # KSOCK='';KFLAG='';  # KSOCK='--to unix:/tmp/kitty-mtx' # KFLAG='-a -c'
  if [ "$TMUX" ]; then TSOCK="$(tmux display -p "#{b:socket_path}")"; else TSOCK="${MX_DEFAULT_TMUX_SOCKET:-master}"; fi

  cp -v "$temp" "$dist"

  Info "○ ${TSOCK}"
  Info "○ $(basename "$M_THEME")"
  
  tmux -L "$TSOCK"  run-shell "tmux source-file $dist"
  tmux -L "$TSOCK"  run-shell "tmux source-file $M_THEME"
  InfoDone
}


