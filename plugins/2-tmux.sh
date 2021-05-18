#!/usr/bin/env bash
# #################

BS="$(GetPlugName).mx"
MXC_TMUX_TMP=/tmp/mxc/"$BS"
MXC_TMUX_OUT="${MXC_TMUX_OUT:-"$MXDIST/$BS"}"

# shellcheck disable=SC2046
PopulateFileWith "$MXC_TMUX_TMP" 'FLUSH' \
  "\${c}=\'\${!c}\'" \
  "${MX_VARS[@]}"
  # $(eval echo \$\{MX_Z{C,X,M,K,L}\[\@\]\})

# since https://github.com/metaory/mxcolr/commit/f6d25e
# most of this file couple be replaced by a simple template file

Info "$MXC_TMUX_TMP"

[ "$TMUX" ] && tmux run-shell "tmux source-file $MXC_TMUX_TMP"
[ "$TMUX" ] && [ "$M_THEME" ] && tmux run-shell "tmux source-file $M_THEME"

apply_tmux () {
  local TSOCK=''; # KSOCK='';KFLAG='';  # KSOCK='--to unix:/tmp/kitty-mtx' # KFLAG='-a -c'
  if [ "$TMUX" ]; then TSOCK="$(tmux display -p "#{b:socket_path}")"; else TSOCK="${MX_DEFAULT_TMUX_SOCKET:-master}"; fi

  cp -v "$MXC_TMUX_TMP" "$MXC_TMUX_OUT"

  tmux -L "$TSOCK"  run-shell "tmux source-file $MXC_TMUX_OUT"
  [ "$M_THEME" ] && tmux -L "$TSOCK" run-shell "tmux source-file $M_THEME"

  InfoDone
}


