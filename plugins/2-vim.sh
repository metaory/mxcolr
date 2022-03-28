#!/usr/bin/env bash

MXC_VIM_TMP=/tmp/mxc/root-mx.vim
MXC_VIM_OUT="$MXDIST"/root-mx.vim

# cat <<  EOF > "$MXC_VIM_TMP"
# $(get_header '\"')
# 
# let g:mxc_g_black ='${DK0}'
# let g:mxc_c_black = ${TDK0}
# 
# let g:mxc_g_white = '${C15}'
# let g:mxc_c_white =  ${TC15}
# EOF

# shellcheck disable=SC2046
PopulateFileWith "$MXC_VIM_TMP" 'FLUSH:"' \
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


apply_vim () {
  cp -v --backup "$MXC_VIM_TMP" "$MXC_VIM_OUT"

  # cp -v /tmp/mxc/mxc-nvim-base16.lua ~/.config/nvim/lua/themes
  # cp -v /tmp/mxc/mxc-nvim-colors.lua ~/.config/nvim/lua/themes
  cp -v /tmp/mxc/vim-visual-multi_themes.vim ~/.local/share/nvim/site/pack/packer/opt/vim-visual-multi/autoload/vm/themes.vim
  # cp -v /tmp/mxc/palette.lua ~/.config/nvim/lua/cosmic/theme/integrated/mxc-palette.lua
  cp -v /tmp/mxc/palette.lua ~/.config/nvim/lua/mxc/palette.lua
  cp -v /tmp/mxc/mxc-nvim-base16.lua ~/.config/nvim/lua/mxc
  cp -v /tmp/mxc/mxc-nvim-colors.lua ~/.config/nvim/lua/mxc

  InfoDone "$MXC_VIM_OUT"
}

