#!/usr/bin/env bash
# #################

MXC_TMUX_TMP=/tmp/mxc/tmux.mx
MXC_TMUX_OUT="${MXC_DEFAULT_TMUX_OUT:-$HOME/.config/tmux/tmux.mx}"
M_THEME=$HOME/.config/tmux/meta.min.tmuxtheme

# shellcheck disable=SC2046
PopulateFileWith "$MXC_TMUX_TMP" 'FLUSH' \
  "\${c}=\'\${!c}\'" \
  "${MX_VARS[@]}"

Info "$MXC_TMUX_TMP"

[ "$TMUX" ] && tmux run-shell "tmux source-file $MXC_TMUX_TMP"
[ "$TMUX" ] && tmux run-shell "tmux source-file $M_THEME"

apply_tmux () {
  local TSOCK=''; # KSOCK='';KFLAG='';  # KSOCK='--to unix:/tmp/kitty-mtx' # KFLAG='-a -c'
  if [ "$TMUX" ]; then TSOCK="$(tmux display -p "#{b:socket_path}")"; else TSOCK="${MX_DEFAULT_TMUX_SOCKET:-master}"; fi

  cp -v $MXC_TMUX_TMP $MXC_TMUX_OUT

  tmux -L "$TSOCK"  run-shell "tmux source-file $MXC_TMUX_OUT"
  [ "$M_THEME" ] && tmux -L "$TSOCK" run-shell "tmux source-file $M_THEME"

  InfoDone
}


