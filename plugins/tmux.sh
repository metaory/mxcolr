#!/usr/bin/env bash
# #################

# ## >>> ##########
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\  

apply_tmux () {


  local TSOCK=''; # KSOCK='';KFLAG='';  # KSOCK='--to unix:/tmp/kitty-mtx' # KFLAG='-a -c'
  if [ -n "$TMUX" ]             ; then 
    TSOCK="$(tmux display -p "#{b:socket_path}")"
  else 
    TSOCK="master"
  fi


  Info "○ ${TSOCK}"
  Info "○ $(basename "$M_THEME")"

  tmux -L "$TSOCK" \
    set-option  -g   "@WBG" "$WBG" \; \
    set-option  -g   "@WFG" "$WFG" \; \
    set-option  -g   "@EBG" "$EBG" \; \
    set-option  -g   "@EFG" "$EFG" \; \
    set-option  -g   "@SBG" "$SBG" \; \
    set-option  -g   "@SFG" "$SFG" \; \
    set-option  -g   "@OBG" "$OBG" \; \
    set-option  -g   "@OFG" "$OFG" \; \
    set-option  -g   "@XBG" "$XBG" \; \
    set-option  -g   "@XFG" "$XFG" \; \
    set-option  -g   "@DK0" "$DK0" \; \
    set-option  -g   "@DK1" "$DK1" \; \
    set-option  -g   "@DK2" "$DK2" \; \
    set-option  -g   "@DK3" "$DK3" \; \
    set-option  -g   "@DK4" "$DK4" \; \
    set-option  -g   "@DK5" "$DK5" \; \
    set-option  -g   "@DK6" "$DK6" \; \
    set-option  -g   "@DK7" "$DK7"

  tmux -L "$TSOCK" \
    set-option  -gw  "@WBG" "$WBG" \; \
    set-option  -gw  "@XBG" "$XBG" \; \
    set-option  -gw  "@OBG" "$OBG"

  tmux -L "$TSOCK"  run-shell "tmux source-file $M_THEME"
  Info "Done" 0
}


