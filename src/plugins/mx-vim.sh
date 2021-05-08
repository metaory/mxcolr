#!/usr/bin/env bash


M_VIM1=$MXTEMP/mx-vim1.vim
M_VIM2=$MXTEMP/mx-vim2.vim
M_VIM3=$MXTEMP/mx-vim3.vim
M_VIM4=$MXTEMP/mx-vim4.vim
M_VIM5=$MXTEMP/mx-vim5.vim

O_VIM1=$MXDIST/mx-vim1.vim
O_VIM2=$MXDIST/mx-vim2.vim
O_VIM3=$MXDIST/mx-vim3.vim
O_VIM4=$MXDIST/mx-vim4.vim
O_VIM5=$MXDIST/mx-vim5.vim

Z_VIM1=$HOME/.SpaceVim.d/autoload/mxpatch.vim
Z_VIM2=$HOME/.SpaceVim/bundle/vim-airline-themes/autoload/airline/themes/mowl.vim
Z_VIM3=$HOME/.cache/vimfiles/repos/github.com/drewtempelmeyer/palenight.vim/autoload/palenight.vim
Z_VIM4=$HOME/.cache/vimfiles/repos/github.com/Yggdroot/LeaderF/autoload/leaderf/colorscheme/meta.vim
Z_VIM5=$HOME/.SpaceVim/autoload/SpaceVim/mapping/guide/theme/palenight.vim

cp "$Z_VIM1" "$M_VIM1"
cp "$Z_VIM2" "$M_VIM2"
cp "$Z_VIM3" "$M_VIM3"
cp "$Z_VIM4" "$M_VIM4"
cp "$Z_VIM5" "$M_VIM5"

sed -r -i \
  -e "/^hi Normal/s/guibg=.\w+/guibg=$XBG/" \
  -e "/^hi Normal/s/guifg=.\w+/guifg=$XFG/" \
  -e "/^hi Visual/s/guibg=.\w+/guibg=$OBG/" \
  -e "/^hi Visual/s/guifg=.\w+/guifg=$OFG/" \
  -e "/^hi CursorLineNr/s/guifg=.\w+/guifg=$WBX/" \
  -e "/^hi LineNr/s/guifg=.\w+/guifg=$DK4/" \
  -e "/^hi Title/s/guifg=.\w+/guifg=$DK5/" \
  -e "/^hi EndOfBuffer/s/guifg=.\w+/guifg=$DK5/" \
  -e "/^hi EndOfBuffer/s/guibg=.\w+/guibg=$DK0/" \
  -e "/^hi CursorColumn/s/guibg=.\w+/guibg=$DK2/" \
  -e "/^hi CursorLine/s/guibg=.\w+/guibg=$DK2/" \
  -e "/^hi ColorColumn/s/guibg=.\w+/guibg=$WBG/" \
  -e "/^hi Comment/s/guifg=.\w+/guifg=$DK4/" \
  \
  -e "/^let g:indentLine_color_gui/s/=.+$/= '${C07}'/" \
  -e "/^let g:indentLine_color_term /s/=.+$/= '${T07}'/" \
  "$M_VIM1"
InfoSourced "VIM-Patch"
  

sed -r -i \
  -e "/^let s:g_xbg /s/\".+$/\"$XBG\"/" \
  -e "/^let s:g_xfg /s/\".+$/\"$XFG\"/" \
  -e "/^let s:g_black /s/\".+$/\"$DK0\"/" \
  \
  -e "/^let s:g_C01 /s/\".+$/\"$C01\"/" \
  -e "/^let s:g_C02 /s/\".+$/\"$C02\"/" \
  -e "/^let s:g_C03 /s/\".+$/\"$C03\"/" \
  -e "/^let s:g_C04 /s/\".+$/\"$C04\"/" \
  -e "/^let s:g_C05 /s/\".+$/\"$C05\"/" \
  \
  -e "/^let s:g_dk1 /s/\".+$/\"$DK1\"/" \
  -e "/^let s:g_dk2 /s/\".+$/\"$DK2\"/" \
  -e "/^let s:g_dk3 /s/\".+$/\"$DK3\"/" \
  -e "/^let s:g_dk4 /s/\".+$/\"$DK4\"/" \
  -e "/^let s:g_dk5 /s/\".+$/\"$DK5\"/" \
  -e "/^let s:g_dk6 /s/\".+$/\"$DK6\"/" \
  -e "/^let s:g_dk7 /s/\".+$/\"$DK7\"/" \
  \
  -e "/^let s:g_obg /s/\".+$/\"$OBG\"/" \
  -e "/^let s:g_ofg /s/\".+$/\"$OFG\"/" \
  \
  -e "/^let s:g_sbg /s/\".+$/\"$SBG\"/" \
  -e "/^let s:g_sfg /s/\".+$/\"$SFG\"/" \
  \
  -e "/^let s:g_wbg /s/\".+$/\"$WBG\"/" \
  -e "/^let s:g_wfg /s/\".+$/\"$WFG\"/" \
  \
  -e "/^let s:g_ebg /s/\".+$/\"$EBG\"/" \
  -e "/^let s:g_efg /s/\".+$/\"$EFG\"/" \
  \
  -e "/^let s:g_wbx /s/\".+$/\"$WBX\"/" \
  -e "/^let s:g_wfx /s/\".+$/\"$WFX\"/" \
  \
  -e "/^let s:g_red_d /s/\".+$/\"$C01\"/" \
  -e "/^let s:g_red_l /s/\".+$/\"$C09\"/" \
  -e "/^let s:g_grn_d /s/\".+$/\"$C02\"/" \
  -e "/^let s:g_grn_l /s/\".+$/\"$C10\"/" \
  -e "/^let s:g_yel_d /s/\".+$/\"$C03\"/" \
  -e "/^let s:g_yel_l /s/\".+$/\"$C11\"/" \
  -e "/^let s:g_blu_d /s/\".+$/\"$C04\"/" \
  -e "/^let s:g_blu_l /s/\".+$/\"$C12\"/" \
  -e "/^let s:g_prp_d /s/\".+$/\"$C05\"/" \
  -e "/^let s:g_prp_l /s/\".+$/\"$C13\"/" \
  -e "/^let s:g_cyn_d /s/\".+$/\"$C06\"/" \
  -e "/^let s:g_cyn_l /s/\".+$/\"$C14\"/" \
  -e "/^let s:g_white /s/\".+$/\"$C15\"/" \
  \
  -e "/^let s:c_red_d /s/=.+$/ = $T01/" \
  -e "/^let s:c_red_l /s/=.+$/ = $T09/" \
  -e "/^let s:c_grn_d /s/=.+$/ = $T02/" \
  -e "/^let s:c_grn_l /s/=.+$/ = $T10/" \
  -e "/^let s:c_yel_d /s/=.+$/ = $T03/" \
  -e "/^let s:c_yel_l /s/=.+$/ = $T11/" \
  -e "/^let s:c_blu_d /s/=.+$/ = $T04/" \
  -e "/^let s:c_blu_l /s/=.+$/ = $T12/" \
  -e "/^let s:c_prp_d /s/=.+$/ = $T05/" \
  -e "/^let s:c_prp_l /s/=.+$/ = $T13/" \
  -e "/^let s:c_cyn_d /s/=.+$/ = $T06/" \
  -e "/^let s:c_cyn_l /s/=.+$/ = $T14/" \
  -e "/^let s:c_white /s/=.+$/ = $T15/" \
  -e "/^let s:c_black /s/=.+$/ = $TK0/" \
  "$M_VIM2"
InfoSourced 'VIM-Airline'


# sed -r -e "/^let s:guiWhite /s/\".+$/\"$C15\"/" $M_VIM5
sed -r -i \
  -e "/^let s:guiBlack/s/=.+$/= '${DK0}'/" \
  -e "/^let s:guiWhite/s/=.+$/= '${C15}'/" \
  -e "/^let s:ctermWhite/s/=.+$/= '${TK0}'/" \
  -e "/^let s:ctermBlack/s/=.+$/= '${T15}'/" \
  \
  -e "/^let s:ctermChangedColor/s/=.+$/= '${TWB}'/" \
  -e "/^let s:guiChangedColor/s/=.+$/= '${WBG}'/" \
  \
  -e "/^let s:guisbg/s/=.+$/= '${SBG}'/" \
  -e "/^let s:guiwbg/s/=.+$/= '${WBG}'/" \
  -e "/^let s:guiebg/s/=.+$/= '${EBG}'/" \
  \
  -e "/^let s:gui00/s/=.+$/= '${C00}'/" \
  -e "/^let s:gui15/s/=.+$/= '${C15}'/" \
  \
  -e "/^let s:cterm01/s/=.+$/= '${T01}'/" \
  -e "/^let s:cterm02/s/=.+$/= '${T02}'/" \
  -e "/^let s:cterm03/s/=.+$/= '${T03}'/" \
  -e "/^let s:cterm04/s/=.+$/= '${T04}'/" \
  -e "/^let s:cterm05/s/=.+$/= '${T05}'/" \
  -e "/^let s:cterm06/s/=.+$/= '${T06}'/" \
  -e "/^let s:cterm07/s/=.+$/= '${T07}'/" \
  -e "/^let s:cterm08/s/=.+$/= '${T08}'/" \
  -e "/^let s:cterm09/s/=.+$/= '${T09}'/" \
  \
  -e "/^let s:gui01/s/=.+$/= '${C01}'/" \
  -e "/^let s:gui02/s/=.+$/= '${C02}'/" \
  -e "/^let s:gui03/s/=.+$/= '${C03}'/" \
  -e "/^let s:gui04/s/=.+$/= '${C04}'/" \
  -e "/^let s:gui05/s/=.+$/= '${C05}'/" \
  -e "/^let s:gui06/s/=.+$/= '${C06}'/" \
  -e "/^let s:gui07/s/=.+$/= '${C07}'/" \
  -e "/^let s:gui08/s/=.+$/= '${C08}'/" \
  -e "/^let s:gui09/s/=.+$/= '${C09}'/" \
  "$M_VIM5"

InfoSourced 'VIM-Mapping'

cat <<  EOF > "$M_VIM3"
let s:overrides = get(g:, "palenight_color_overrides", {})
let s:colors = {
      \ "sbg": get(s:overrides            , "red"            , { "gui": "${SBG}" , "cterm": "${TSB}" , "cterm16": "9" })  ,
      \ "sfg": get(s:overrides            , "red"            , { "gui": "${SFG}" , "cterm": "${TSF}" , "cterm16": "9" })  ,
      \ "wbg": get(s:overrides            , "red"            , { "gui": "${WBG}" , "cterm": "${TWB}" , "cterm16": "9" })  ,
      \ "wfg": get(s:overrides            , "red"            , { "gui": "${WFG}" , "cterm": "${TWF}" , "cterm16": "9" })  ,
      \ "red": get(s:overrides            , "red"            , { "gui": "${C01}" , "cterm": "${TX1}" , "cterm16": "9" })  ,
      \ "light_red": get(s:overrides      , "light_red"      , { "gui": "${C09}" , "cterm": "${T09}" , "cterm16": "9" })  ,
      \ "dark_red": get(s:overrides       , "dark_red"       , { "gui": "${CX1}" , "cterm": "${TX1}" , "cterm16": "1" })  ,
      \ "green": get(s:overrides          , "green"          , { "gui": "${C02}" , "cterm": "${T02}" , "cterm16": "6" })  ,
      \ "dark_green": get(s:overrides     , "green"          , { "gui": "${CX2}" , "cterm": "${TX2}" , "cterm16": "2" })  ,
      \ "light_yellow": get(s:overrides   , "yellow"         , { "gui": "${C11}" , "cterm": "${T11}" , "cterm16": "3" })  ,
      \ "yellow": get(s:overrides         , "light_yellow"   , { "gui": "${C03}" , "cterm": "${T03}" , "cterm16": "3" })  ,
      \ "dark_yellow": get(s:overrides    , "dark_yellow"    , { "gui": "${CX3}" , "cterm": "${TX3}" , "cterm16": "13" }) ,
      \ "blue": get(s:overrides           , "blue"           , { "gui": "${CX4}" , "cterm": "${TX4}" , "cterm16": "4" })  ,
      \ "purple": get(s:overrides         , "purple"         , { "gui": "${CX5}" , "cterm": "${TX4}" , "cterm16": "5" })  ,
      \ "blue_purple": get(s:overrides    , "blue_purple"    , { "gui": "${SBG}" , "cterm": "${TSB}" , "cterm16": "4"})   ,
      \ "cyan": get(s:overrides           , "cyan"           , { "gui": "${C06}" , "cterm": "${T06}" , "cterm16": "14" }) ,
      \ "white": get(s:overrides          , "white"          , { "gui": "${C15}" , "cterm": "${T15}" , "cterm16": "7" })  ,
      \ "black": get(s:overrides          , "black"          , { "gui": "${DK0}" , "cterm": "${TK0}" , "cterm16": "0" })  ,
      \ "visual_black": get(s:overrides   , "visual_black"   , { "gui": "NONE"   , "cterm": "NONE"   , "cterm16": "0" })  ,
      \ "gutter_fg_grey": get(s:overrides , "gutter_fg_grey" , { "gui": "${DK5}" , "cterm": "${TK5}" , "cterm16": "15" }) ,
      \ "comment_grey": get(s:overrides   , "comment_grey"   , { "gui": "${DL4}" , "cterm": "${TL4}" , "cterm16": "8" })  ,
      \ "cursor_grey": get(s:overrides    , "cursor_grey"    , { "gui": "${DK1}" , "cterm": "${TK1}" , "cterm16": "8" })  ,
      \ "visual_grey": get(s:overrides    , "visual_grey"    , { "gui": "${DK4}" , "cterm": "${TK4}" , "cterm16": "15" }) ,
      \ "menu_grey": get(s:overrides      , "menu_grey"      , { "gui": "${DK0}" , "cterm": "${TK0}" , "cterm16": "8" })  ,
      \ "special_grey": get(s:overrides   , "special_grey"   , { "gui": "${DK7}" , "cterm": "${TK7}" , "cterm16": "15" }) ,
      \ "vertsplit": get(s:overrides      , "vertsplit"      , { "gui": "${DK0}" , "cterm": "${TK0}" , "cterm16": "15" }) ,
      \ "white_mask_1": get(s:overrides   , "white_mask_1"   , { "gui": "${DK1}" , "cterm": "${TK1}" , "cterm16": "15" }) ,
      \ "white_mask_3": get(s:overrides   , "white_mask_3"   , { "gui": "${DK2}" , "cterm": "${TK2}" , "cterm16": "8" })  ,
      \ "white_mask_11": get(s:overrides  , "white_mask_11"  , { "gui": "${DK3}" , "cterm": "${TK3}" , "cterm16": "4" })
      \}
function! palenight#GetColors()
  return s:colors
endfunction
EOF
InfoSourced "VIM-Palenight"

cat <<  EOF > "$M_VIM4"
" ============================================================================
" File:        meta.vim
" Description:
" Author:      Metaory <metaory@gmail.com>
" Website:     https://github.com/metaory
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

let s:palette = {
            \   'Lf_hl_match': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '${EBG}',
            \       'guibg': '${SBG}',
            \       'cterm': 'NONE',
            \       'ctermfg': 'NONE',
            \       'ctermbg': '${TXB}'
            \   },
            \   'Lf_hl_match0': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '${EBG}',
            \       'guibg': '${WBG}',
            \       'cterm': 'NONE',
            \       'ctermfg': 'NONE',
            \       'ctermbg': '${TWB}'
            \   },
            \   'stlName': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': '${SFG}',
            \       'guibg': '${SBG}',
            \       'cterm': 'bold',
            \       'ctermfg': '${TSF}',
            \       'ctermbg': '${TSB}'
            \   },
            \   'stlCategory': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': '${EFG}',
            \       'guibg': '${EBG}',
            \       'cterm': 'NONE',
            \       'ctermfg': '${TEF}',
            \       'ctermbg': '${TEB}'
            \   },
            \   'stlNameOnlyMode': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': '${WFG}',
            \       'guibg': '${WBG}',
            \       'cterm': 'NONE',
            \       'ctermfg': '${TWF}',
            \       'ctermbg': '${TWB}'
            \   },
            \   'stlFullPathMode': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': '${EFG}',
            \       'guibg': '${EBG}',
            \       'cterm': 'NONE',
            \       'ctermfg': '16',
            \       'ctermbg': '147'
            \   },
            \   'stlFuzzyMode': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': '${EFG}',
            \       'guibg': '${EBG}',
            \       'cterm': 'NONE',
            \       'ctermfg': '${TEF}',
            \       'ctermbg': '${TEB}'
            \   },
            \   'stlRegexMode': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': '${WFX}',
            \       'guibg': '${WBX}',
            \       'cterm': 'NONE',
            \       'ctermfg': '${TWF}',
            \       'ctermbg': '${TWB}'
            \   },
            \   'stlCwd': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '${WBX}',
            \       'guibg': '${DK3}',
            \       'cterm': 'NONE',
            \       'ctermfg': '${TWF}',
            \       'ctermbg': '${TK3}'
            \   },
            \   'stlBlank': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': 'NONE',
            \       'guibg': 'NONE',
            \       'cterm': 'NONE',
            \       'ctermfg': '${TEF}',
            \       'ctermbg': '${TEB}'
            \   },
            \   'stlSpin': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '${WFG}',
            \       'guibg': '${WBG}',
            \       'cterm': 'NONE',
            \       'ctermfg': '${TWF}',
            \       'ctermbg': '${TWB}'
            \   },
            \   'stlLineInfo': {
            \       'gui': 'bold',
            \       'font': 'NONE',
            \       'guifg': '${EFG}',
            \       'guibg': '${EBG}',
            \       'cterm': 'NONE',
            \       'ctermfg': '${TEF}',
            \       'ctermbg': '${TEB}'
            \   },
            \   'stlTotal': {
            \       'gui': 'NONE',
            \       'font': 'NONE',
            \       'guifg': '${OFG}',
            \       'guibg': '${OBG}',
            \       'cterm': 'NONE',
            \       'ctermfg': '${TOF}',
            \       'ctermbg': '${TOB}'
            \   }
            \ }

let g:leaderf#colorscheme#meta#palette = leaderf#colorscheme#mergePalette(s:palette)
EOF
InfoSourced "VIM-LeaderF"


ApplyVim () {
  cp "$M_VIM1" "$O_VIM1"
  cp "$M_VIM2" "$O_VIM2"
  cp "$M_VIM3" "$O_VIM3"
  cp "$M_VIM4" "$O_VIM4"
  cp "$M_VIM5" "$O_VIM5"

  cp "$O_VIM1" "$Z_VIM1"
  cp "$O_VIM2" "$Z_VIM2"
  cp "$O_VIM3" "$Z_VIM3"
  cp "$O_VIM4" "$Z_VIM4"
  cp "$O_VIM5" "$Z_VIM5"
  Info "Done" 0
}
