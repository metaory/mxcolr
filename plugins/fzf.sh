#!/usr/bin/env bash

M_FZF=$MXTEMP/mx-fzf
O_FZF=$HOME/.profile

FZF_COLOR_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:${XFG},bg:${XBG},hl:${WBG} \
  --color=fg+:${SBG},bg+:${DK0},hl+:${WBX} \
  --color=info:${EBG},prompt:${C08},pointer:${WBX} \
  --color=marker:${C01},spinner:${WBG},header:${C01}"

sed -r \
  -e "s/^export FZF_DEFAULT_OPTS=.+$/export FZF_DEFAULT_OPTS=\"$FZF_COLOR_OPTS\"/" \
  "$O_FZF" > "$M_FZF"

InfoSourced

apply_fzf () {
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  cp "$M_FZF" "$O_FZF"
  Info "Done" 0
}
