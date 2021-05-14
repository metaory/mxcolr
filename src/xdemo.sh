#!/usr/bin/env bash
# . /home/metaory/dev/meta/configs/scripts/m.lib/lib.common.sh

PAINT=$MXBASE/src/paint.sh

################################
prnt1 (){
  pastel paint "${3:-$(pastel textcolor "$1")}" -o "$1" -b -n "┠${1}┨"
  pastel paint "${1}" -o "$XBG" "$2 $(bullshit | cut -d' ' -f1-2)"
}
################################
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\  
ca=(C00 C01 C02 C03 C04 C05 C06 C07)
cb=(C08 C09 C10 C11 C12 C13 C14 C15)
cx=(CX1 CX2 CX3 CX4 CX5 CX6)
# ////////////////////////////  
tx=(SBG WBG EBG)
dk=(DK0 DK1 DK2 DK3 DK4 DK5 DK6 DK7 DL8 DL9)
dl=(DL0 DK1 DK2 DK3 DL4 DL5 DL6 DL7 DL8 DL9)
# ////////////////////////////  
Demo_large_block () {
  
  pl '-'; pl '-'; pl '-'; pl '-'
  sp_block_d_middl='████'
  fill 5 ; pl "${tx[0]}" "▄▄▄" ; prntlist 'pl:sp_block_d' "${tx[@]}" ; pl "${tx[-1]}" '▀▀▀' ; pl '-'
  pl '-'; pl '-'; pl '-'; pl '-'
}
# ////////////////////////////  
Demo_block () {
  [[ -z $2 ]] && { fill 8 ; pl "${tx[0]}" "${1-${MXNAME:0:2}}" ; pl "${tx[1]}"  "${MXNAME:2:4}" ;pl "${tx[2]}" "${MXNAME:8:16}"; pl '-'; }
  fill 5 ; pl "${tx[0]}"   " ▄▄" ; prntlist 'prnt:sp_block_d' "${tx[@]}" ; pl "${tx[-1]}" '▀▀' ; pl '-'
}
Demo_full_block () {
  local head="${1:-}"
  fill 1 ; pl "${tx[0]}" "${head}  " ; prntlist 'prnt:sp_blank' "${tx[@]}"   ; pl "${tx[-1]}" '   ' ; pl '-'
  fill 6 ; pl "${tx[0]}" " ▄▄" ; prntlist 'prnt:sp_block_d' "${tx[@]}" ; pl "${tx[-1]}" '▀▀ ' ; pl '-'
  fill 7 ; pl "${tx[0]}" "   " ; prntlist 'prnt:sp_blank' "${tx[@]}"   ; pl "${tx[-1]}" '   ' ; pl '-'
}
Demo_slant () {
  # ########################################
  # echo "DEMO SLANT, ${cb[*]}"
  Demo_block 1
  # fill 1 ; pl                  ; prntlist 'pl:sp_line'  "${tx[@]}"  ; pl '-'
  # ........................................
  # ########################################
  fill 1; pl                  ; prntlist 'prnt:sp_line_top'  "${ca[@]}" ; pl '-'
  fill 1; pl "${ca[0]}" " ┗━" ; prntlist 'prnt:sp_block_l'   "${ca[@]}" ; pl "${ca[-1]}" '┛' ; pl '-'
  # ........................................
  # ########################################
  fill 1; pl "${cb[0]}" ' ┏━╺' ; prntlist 'prnt:sp_block_l'  "${cb[@]}"; pl '-'
  fill 1; pl                   ; prntlist 'prnt:sp_line_bot' "${cb[@]}"; pl '-'
  # ........................................
  # ########################################
  # ........................................
  fill 4     ; prntlist 'pl:sp_line_top_mini' "${cx[@]}" ; pl '-'
  fill 4     ; pl "${cx[0]}" "┗━"                        ; prntlist 'prnt:sp_block_c' "${cx[@]}" ; pl "${cx[-1]}" "━┛"; pl '-'
  fill 7 ; prntlist 'pl:sp_line_bo2' "${cx[@]}"          ; pl '-'
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
  local s; s="${1}"
  local filler
  if [[ "$2" = 'I' ]]; then filler='█'; else filler=' '; s=" ${s}"; fi
  local fill; fill="$(printf "%0.s${filler}" $(seq 1 6))"
  local out="${s}${fill}"; out="${out::3}"

  if   [[ "$#" -eq 0 ]]; then pastel paint "$XBG" -n "$out"
  elif [[ "$2" = 'I' ]]; then pastel paint "$WBG" -n "$out"
  else pastel paint "$WFG" -o "$WBG" -n "$out"; fi
}
Demo_card () {
  local s="${1:-$MXNAME}"; local c="${2:-}"; local t="${3:-}"
  local cy=("${tx[@]}" "${cx[@]}")
  _head ; _title "$s"
  _head "$c"  0 '-b' ; prntlist 'pl:sp_tiny' "${ca[@]}" ; pl '-'
  _head "∕"   0      ; prntlist 'pl:sp_tiny' "${cb[@]}" ; pl '-'
  _head "$t"  0      ; prntlist 'pl:sp_tiny' "${cy[@]}" ; pl '-'
  _head " "   0      ; prntlist 'pl:sp_tiny' "${dl[@]}" ; pl '-'
  _head "██"  I     ; prntlist 'pl:sp_tiny' "${dk[@]}" ; pl '-'

  # _head "$t"  0      ; prntlist 'pl:sp_tiny' "${cx[@]}" ; pl '-'
}
# ##############################

Demo_shades()  {
  pl "${dk[0]}" ' ┏╸━' ; prntlist 'prnt:sp_block_l'  "${dk[@]}" ; pl '-'
  pl                   ; prntlist 'prnt:sp_line_bot' "${dk[@]}"  ; pl '-'
}
Demo_shades1()  { fill 1; prntlist 'prnt:sp_lash' "${dk[@]}" ; pl '-'; }
Demo_shades2()  { fill 1; prntlist 'prnt:sp_pentagon' "${dk[@]}" ; pl '-'; }
Demo_shades3()  { fill 3; prntlist 'prnt:sp_dotline' "${dk[@]}" ; pl '-'; }
Demo_shades4()  { 
  fill 3; prntlist 'prnt:sp_block_e' "${dk[@]}" ; pl '-'
  fill 3; prntlist 'prnt:sp_block_e' "${dl[@]}" ; pl '-'
}

Demo_dot_slant () {
  sp_cross_begin='┏╸'; sp_cross_close=' ╺┓'
  fill 5 ; prntlist 'prnt:sp_cross' "${cx[@]}"     ; pl '-'
  fill 3 ; prntlist 'prnt:sp_circle_slant' "${ca[@]:1:6}" ; pl '-'
  sp_cross_close=' ╺┛'; sp_cross_begin='┗╸'
  fill 5 ; prntlist 'prnt:sp_cross' "${cb[@]:1:6}" ; pl '-'
}

# ##############################
Demo_dot () {
  fill 9; prntlist 'prnt:sp_dot' "${tx[@]}"; pl '-'
  fill 6;  prntlist 'prnt:sp_dot' "${cx[@]}"; pl '-'
  fill 4;  prntlist 'prnt:sp_dot' "${ca[@]}"; pl '-'
  fill 4;  prntlist 'prnt:sp_dot' "${cb[@]}"; pl '-'
  fill 2;  prntlist 'prnt:sp_dot' "${dk[@]}"; pl '-'
  fill 2;  prntlist 'prnt:sp_dot' "${dl[@]}"; pl '-'
}
# ////////////////////////////  
# ##############################
# ·╺━╸⏽ ●  ● ⏽╺━╸·
MXDots-full () { local cb=(C00 C01 C02 C03 C04 C05 C06 C07 C08 C09 C10 C11 C12 C13 C14 C15); prntlist 'prnt:sp_dot' "${cb[@]}" ; pl ; }
MXDots () { local cb=(SBG WBG EBG); prntlist 'prnt:sp_dot' "${cb[@]}" ; pl ; }

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
# ━

# ////////////////////////////  
