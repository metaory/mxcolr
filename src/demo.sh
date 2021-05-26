#!/usr/bin/env bash

MX_XX=(SBG WBG EBG)
MX_CA=(C{00..07})
MX_CB=(C{08..15})

################################
prnt1 (){
  pastel paint "${3:-$(pastel textcolor "$1")}" -o "$1" -b -n "┠${1}┨"
  pastel paint "${1}" -o "$XBG" "$2 $(bullshit | cut -d' ' -f1-2)"
}
################################
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\  
# ////////////////////////////  
Demo_large_block () {
  
  pl '-'; pl '-'; pl '-'; pl '-'
  sp_block_d_middl='████'
  fill 5 ; pl "${MX_XX[0]}" "▄▄▄" ; prntlist 'pl:sp_block_d' "${MX_XX[@]}" ; pl "${MX_XX[-1]}" '▀▀▀' ; pl '-'
  pl '-'; pl '-'; pl '-'; pl '-'
}
# ////////////////////////////  
Demo_block () {
  [[ -z $2 ]] && { fill 8 ; pl "${MX_XX[0]}" "${1-${MXNAME:0:2}}" ; pl "${MX_XX[1]}"  "${MXNAME:2:4}" ;pl "${MX_XX[2]}" "${MXNAME:8:16}"; pl '-'; }
  fill 5 ; pl "${MX_XX[0]}"   " ▄▄" ; prntlist 'prnt:sp_block_d' "${MX_XX[@]}" ; pl "${MX_XX[-1]}" '▀▀' ; pl '-'
}
Demo_full_block () {
  local head="${1:-}"
  fill 1 ; pl "${MX_XX[0]}" "${head}  " ; prntlist 'prnt:sp_blank' "${MX_XX[@]}"   ; pl "${MX_XX[-1]}" '   ' ; pl '-'
  fill 6 ; pl "${MX_XX[0]}" " ▄▄"       ; prntlist 'prnt:sp_block_d' "${MX_XX[@]}" ; pl "${MX_XX[-1]}" '▀▀ ' ; pl '-'
  fill 7 ; pl "${MX_XX[0]}" "   "       ; prntlist 'prnt:sp_blank' "${MX_XX[@]}"   ; pl "${MX_XX[-1]}" '   ' ; pl '-'
}
Demo_slant () {
  # ########################################
  # echo "DEMO SLANT, ${MX_CB[*]}"
  Demo_block 1
  # fill 1 ; pl                  ; prntlist 'pl:sp_line'  "${MX_XX[@]}"  ; pl '-'
  # ........................................
  # ########################################
  fill 1 ; pl                     ; prntlist 'prnt:sp_line_top' "${MX_CA[@]}" ; pl '-'
  fill 1 ; pl "${MX_CA[0]}" " ┗━" ; prntlist 'prnt:sp_block_l'  "${MX_CA[@]}" ; pl "${MX_CA[-1]}" '┛' ; pl '-'
  # ........................................
  # ########################################
  fill 1 ; pl "${MX_CB[0]}" ' ┏━╺' ; prntlist 'prnt:sp_block_l'  "${MX_CB[@]}" ; pl '-'
  fill 1 ; pl                      ; prntlist 'prnt:sp_line_bot' "${MX_CB[@]}" ; pl '-'
  # ........................................
  # ########################################
  # ........................................

  fill 4     ; prntlist 'pl:sp_line_top_mini' "${MX_CX[@]}" ; pl '-'
  fill 4     ; pl "${MX_CX[0]}" "┗━"                        ; prntlist 'prnt:sp_block_c' "${MX_CX[@]}" ; pl "${MX_CX[-1]}" "━┛"; pl '-'
  fill 7 ; prntlist 'pl:sp_line_bo2' "${MX_CX[@]}"          ; pl '-'
  # ########################################
}

# ##############################
# ## CARD DEMO #################
# ##############################
_title () {
  local tlen=9
  local label="${1^^}"
  label="${label:0:$tlen}"
  local llen=${#label}

  local flen=$((tlen-llen+1))
  local fill; fill=$(printf "%0.s " $(seq 1 "$flen"))
  local out="${label}${fill}"

  pastel paint "$DK0" -n "  ██"
  pastel paint "$XFG" -n -i -o "$DK0" " ${out} "
  pastel paint "$DK0"  "█"
}
_head () {
  local s="${1}"
  local filler=' '
  (( "$2" )) && filler='█'
  local fill; fill="$(printf "%0.s${filler}" $(seq 1 6))"

  local out="${s}${fill}"; out=" ${out::3}"
  local bg="$WBG"
  local fg="$WFG"
  (( $2 )) && bg="$XBG" && fg="$WBG"; # || out=" ${out}"

  pastel paint -n -o "$bg" "$fg" "$out" 

  # ! (( "$#" )) && pastel paint "$XBG" -n "$out"
  #   (( "$2" )) && pastel paint "$XBG" -n "$out"
  # ! (( "$2" )) && pastel paint "$WFG" -o "$WBG" -n "$out"
# pastel paint "$WFG" -o "$WBG" -n "$out"
# pastel paint "$XBG" -n "$out"
# pastel paint "$WFG" -o "$WBG" -n "$out"
  # if   [[ "$#" -eq 0 ]]; then pastel paint "$XBG" -n "$out"
  # elif [[ "$2" -eq 1 ]]; then pastel paint "$WBG" -n "$out"
  # else pastel paint "$WFG" -o "$WBG" -n "$out"; fi
}
Demo_card () {
  local s="${1:-$MXNAME}"; local c="${2:-}"; local t="${3:-}"
  local cy=("${MX_XX[@]}" "${MX_CX[@]}")
  fll 8                     ; _title "$s"
  fll 8; _head "$c"  0 '-b' ; prntlist 'prnt:sp_tiny' "${MX_CA[@]}" ; echo
  fll 8; _head "∕"   0      ; prntlist 'prnt:sp_tiny' "${MX_CB[@]}" ; echo
  fll 8; _head "$t"  0      ; prntlist 'prnt:sp_tiny' "${cy[@]}"    ; echo
  fll 8; _head " "   0      ; prntlist 'prnt:sp_tiny' "${MX_CL[@]}" ; echo
  fll 8; _head "██" 1      ; prntlist 'prnt:sp_tiny' "${MX_CK[@]}" ; echo
}
# ##############################

Demo_shades()  {
  pl "${MX_CK[0]}" ' ┏╸━' ; prntlist 'prnt:sp_block_l'  "${MX_CK[@]}" ; pl '-'
  pl                      ; prntlist 'prnt:sp_line_bot' "${MX_CK[@]}" ; pl '-'
}
Demo_shades1()  { fill 1 ; prntlist 'prnt:sp_lash' "${MX_CK[@]}"     ; pl '-' ; }
Demo_shades2()  { fill 1 ; prntlist 'prnt:sp_pentagon' "${MX_CK[@]}" ; pl '-' ; }
Demo_shades3()  { fill 3 ; prntlist 'prnt:sp_dotline' "${MX_CK[@]}"  ; pl '-' ; }
Demo_shades4()  { 
  fill 3; prntlist 'prnt:sp_block_e' "${MX_CK[@]}" ; pl '-'
  fill 3; prntlist 'prnt:sp_block_e' "${MX_CL[@]}" ; pl '-'
}

Demo_mxname () {
  fll 2
  pastel paint -n -b -o "$SBG" "$SFG" " ${1:-$USER} "
  pastel paint -n -b -o "$WBG" "$WFG" " $MXNAME "
  pastel paint -n -b -o "$EBG" "$EFG" " $MXC_V "
}
Demo_dot_slant () {
  sp_cross_begin='┏╸'; sp_cross_close=' ╺┓'
  fill 5 ; prntlist 'prnt:sp_cross' "${MX_CX[@]}"     ; pl '-'
  fill 3 ; prntlist 'prnt:sp_circle_slant' "${MX_CA[@]:1:6}" ; pl '-'
  sp_cross_close=' ╺┛'; sp_cross_begin='┗╸'
  fill 5 ; prntlist 'prnt:sp_cross' "${MX_CB[@]:1:6}" ; pl '-'
}

# ##############################
Demo_dot () {
  fill 9 ; prntlist 'prnt:sp_dot' "${MX_XX[@]}" ; pl '-'
  fill 6 ; prntlist 'prnt:sp_dot' "${MX_CX[@]}" ; pl '-'

  # echo "CA "${MX_CA[*]}""
  fill 4 ; prntlist 'prnt:sp_dot' "${MX_CA[@]}" ; pl '-'
  # echo "CB "${MX_CB[*]}""

  fill 4 ; prntlist 'prnt:sp_dot' "${MX_CB[@]}" ; pl '-'
  fill 2 ; prntlist 'prnt:sp_dot' "${MX_CK[@]}" ; pl '-'
  fill 2 ; prntlist 'prnt:sp_dot' "${MX_CL[@]}" ; pl '-'
}
# ////////////////////////////  
# ##############################
# ·╺━╸⏽ ●  ● ⏽╺━╸·
MXDots-full () { prntlist 'prnt:sp_dot' "${MX_XX[@]}" ; pl ; }
MXDots () { prntlist 'prnt:sp_dot' "${MX_XX[@]}"      ; pl ; }

MXDotLine () {
  local cols;cols=$(tput cols); fill 0
  pl 'C08' '·╺╺╺╸╺━╸⏽'; MXDots; pl 'C08' '⏽╺━╸╺╸╸╸·'; pl '-'
}
MXDotLine-full () {
  local cols;cols=$(tput cols); fill 0
  pl 'C08' '·╺╺╺╸━╸╺━╸⏽'; MXDots-full; pl 'C08' '⏽╺━╸╺━╺╸╸╸·'; pl '-'
}
# shellcheck disable=SC2046
__randmico () { shuf -n 1 -e $(cat ~/mxx/mico/uni-etc); }

MXMico () { ( (( RANDOM % 2 )) &&  MXDots ) || __randmico; }

MXIntro () { ( (( RANDOM % 2 )) &&  MXDotLine ) || ( pl '-' ; Demo_block 0 0 ); }
MYIntro () { 
  case $(( RANDOM % 3 )) in
    0 ) MXDotLine ;;
    1 ) MXDotLine-full ;;
    2 ) Demo_block ;;
  esac
}
  # if (( RANDOM % 2 )); then MXDotLine; else Demo_block; fi
# ////////////////////////////  
# ////////////////////////////  
Demo () {
  Demo_mxname "$USER"; echo; echo
  Demo_block
  Demo_dot
  MXDotLine
  fillCols
}
DemoAll () {
  Demo_card "$USER"
  Demo_slant
  Demo_shades3
  Demo_shades4

  Demo_dot_slant
  MXDotLine
  fillCols
}

