#!/usr/bin/env bash

BS="$(GetPlugName)"
MXC_FZF_TMP=/tmp/mxc/"$BS"
MXC_FZF_OUT="${MXC_FZF_OUT:-"$HOME/.zprofile"}"


FZF_COLOR_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:${XFG},bg:${XBG},hl:${WBG} \
  --color=fg+:${SBG},bg+:${DK0},hl+:${WBX} \
  --color=info:${EBG},prompt:${C08},pointer:${WBX} \
  --color=marker:${C01},spinner:${WBG},header:${C01}"

if ! [ -e "$MXC_FZF_OUT" ]; then 
  Info 1 "$MXC_FZF_OUT doesnt exists"
  return
fi

sed -r \
  -e "s/^export FZF_DEFAULT_OPTS=.+$/export FZF_DEFAULT_OPTS=\"$FZF_COLOR_OPTS\"/" \
  "$MXC_FZF_OUT" > "$MXC_FZF_TMP"

InfoDone "$MXC_FZF_TMP"

apply_fzf () {
  cp -v --backup "$MXC_FZF_TMP" "$MXC_FZF_OUT"
  InfoDone "$MXC_FZF_OUT"
}
