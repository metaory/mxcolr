#!/usr/bin/env bash
BS="$(GetPlugName)-mx.vim"
MXC_VIM_TMP=/tmp/mxc/"$BS"
MXC_VIM_OUT="${MXC_VIM_OUT:-"$MXDIST/$BS"}"



cat <<  EOF > "$MXC_VIM_TMP"
hi Title        ctermfg=$TWB guifg=$C07
hi Normal       ctermfg=62   ctermbg=234 uibg=$XBG  guifg=$XFG
hi Visual       ctermbg=$TOB guibg=$OBG  guifg=$OFG gui=bold
hi CursorLineNr guifg=$WBX
hi LineNr       guifg=$DK4
hi Title        guifg=$SBG
hi EndOfBuffer  guibg=$DK0
hi CursorColumn guibg=$DK2
hi CursorLine   guibg=$DK2
hi ColorColumn  guibg=$WBG
hi Comment      guifg=$DK4

let g:indentLine_color_gui  = '${C08}'
let g:indentLine_color_term = '${T08}'

hi def link LeaderGuideDesc String
hi def link LeaderGuideKeys Constant
hi def link LeaderGuideBrackets Comment
hi def link LeaderGuideGroupName Identifier
hi def link SpaceVimLeaderGuiderGroupName Statement
EOF

# shellcheck disable=SC2046
PopulateFileWith "$MXC_VIM_TMP" 'APPEND' \
  "let g:mxc_g_\${c,,} = \'\${!c}\'" \
  $(eval echo \$\{MX_C{C,X,M,K,L}\[\@\]\})
  # eval 'echo \$\{MX_C{C,X,M,K,L}\[\@\]\}'

# shellcheck disable=SC2046
PopulateFileWith "$MXC_VIM_TMP" 'APPEND' \
  "let g:mxc_c_\${c,,} = \'\${!c}\'" \
  $(eval echo \$\{MX_T{C,X,M,K,L}\[\@\]\})
  # eval 'echo \$\{MX_T{C,X,M,K,L}\[\@\]\}'


apply_vim () {
  cp -v --backup "$MXC_VIM_TMP" "$MXC_VIM_OUT"

  InfoDone "$MXC_VIM_OUT"
}

