#!/usr/bin/env bash
# BS="$(GetPlugName)-mx.vim"
MXC_VIM_TMP=/tmp/mxc/root-mx.vim
MXC_VIM_OUT="$MXDIST"/root-mx.vim

cat <<  EOF > "$MXC_VIM_TMP"
$(get_header '\"')

hi Title        ctermfg=$TWBG guifg=$SBG
hi Normal       ctermfg=$TXFG ctermbg=$TXBG guibg=$XBG guifg=$XFG
hi Visual       ctermbg=$TOBG guibg=$OBG    guifg=$OFG gui=bold
hi CursorLineNr guifg=$WBX    gui=bold
hi LineNr       guifg=$C07
hi EndOfBuffer  guibg=$DK0
hi CursorColumn guibg=$C00
hi CursorLine   guibg=$C00
hi ColorColumn  guibg=$WBG
hi Comment      guifg=$C08

let g:indentLine_color_gui  = '${C08}'
let g:indentLine_color_term = ${TC08}

let g:mxc_g_black ='${DK0}'
let g:mxc_c_black = ${TDK0}

let g:mxc_g_white = '${C15}'
let g:mxc_c_white =  ${TC15}
EOF

# shellcheck disable=SC2046
PopulateFileWith "$MXC_VIM_TMP" 'APPEND' \
  "let g:mxc_g_\${c,,} = \'\${!c}\'" \
  "${MX_VARS[@]}"
  # $(eval echo \$\{MX_C{C,X,M,K,L}\[\@\]\})

# shellcheck disable=SC2046
PopulateFileWith "$MXC_VIM_TMP" 'APPEND' \
  "let g:mxc_c_\${c,,} = \'\${!c}\'" \
  "${MX_TERM[@]}"
  # $(eval echo \$\{MX_T{C,X,M,K,L}\[\@\]\})
  # "*.\${c/color}: \${!c}" \
Info "$MXC_VIM_TMP"

# since https://github.com/metaory/mxcolr/commit/f6d25e
# most of this file couple be replaced by a simple template file

apply_vim () {
  # PressToContinue "[${BASH_SOURCE[0]}]__C05__${C05}"
  cp -v --backup "$MXC_VIM_TMP" "$MXC_VIM_OUT"

  InfoDone "$MXC_VIM_OUT"
}

