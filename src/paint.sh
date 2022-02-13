#!/usr/bin/env bash

sp_block_l_begin='▌'         ; sp_block_l_middl=''       ; sp_block_l_close='▐'
sp_pentagon_begin=''        ; sp_pentagon_middl=''      ; sp_pentagon_close=''
sp_tiny_begin=' '            ; sp_tiny_middl=' '          ; sp_tiny_close=' '
sp_blank_begin='  '           ; sp_blank_middl='  '         ; sp_blank_close='  '            ;
sp_block_l_begin=''         ; sp_block_l_middl=''       ; sp_block_l_close=''
sp_block_c_begin='█'         ; sp_block_c_middl=''       ; sp_block_c_close='█'
sp_block_d_begin='█'         ; sp_block_d_middl='██'     ; sp_block_d_close='█'
sp_block_e_begin='▆ '         ; sp_block_e_middl='▆ '       ; sp_block_e_close='▆'
sp_block_r_begin=''         ; sp_block_r_middl=''       ; sp_block_r_close=''
sp_line_top_begin='┏╸━'       ; sp_line_top_middl='━╸'      ; sp_line_top_close='━━╸━┓'
sp_line_begin='╺╸'           ; sp_line_middl='··'         ; sp_line_close='·╺╸'
sp_line_top_begin='┏╸'       ; sp_line_top_middl='·'      ; sp_line_top_close='·╺┓'       ; #   
sp_cross_begin=' '           ; sp_cross_middl=' '         ; sp_cross_close=' '
sp_dot_begin=' '             ; sp_dot_middl=' ⬤'           ; sp_dot_close='  '
sp_lash_begin='●'            ; sp_lash_middl='●'          ; sp_lash_close='●●'
sp_dotline_begin='╸⏽'         ; sp_dotline_middl='●⏽'       ; sp_dotline_close='╺'
sp_lash_begin='╸⏽'           ; sp_lash_middl='●⏽'          ; sp_lash_close='●╺'
sp_box_slant_begin='█┣╸●'    ; sp_box_slant_middl=' '     ; sp_box_slant_close=' ●╺┫█'
sp_circle_slant_begin='█┣ ●' ; sp_circle_slant_middl=' '  ; sp_circle_slant_close=' ● ┫█'
sp_dot_slant_begin='█🮈╸'    ; sp_dot_slant_middl='·'     ; sp_dot_slant_close='·╺▍█'
sp_line_top_mini_begin='┏╸'  ; sp_line_top_mini_middl='·' ; sp_line_top_mini_close='·╺╺┓'
sp_line_bot_begin='┗━╺╸╺╸'    ; sp_line_bot_middl='╺━'      ; sp_line_bot_close='┛'
sp_line_bo2_begin='┗╸'        ; sp_line_bo2_middl='╺╸'      ; sp_line_bo2_close='┛'
sp_box_begin='■'              ; sp_box_middl='■'            ; sp_box_close='■'
sp_box2_begin='█🮈'            ; sp_box2_middl='▍'           ; sp_box2_close='▍█'

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\  
prnt (){
  char="${2:-}"
  pastel paint -o "$XBG" -n "${!1:-red}" "$char" 
}
pl () {
  [ $# -eq 0 ] && printf ' ' && return
  c="${1:-XBG}"
  s="${2:- }"
  o="$XBG"
  if [[ "$1" == '-' ]]; then
    s=''
    op='-b'
    c='XBG'
  else 
   op='-n'
  fi
  pastel paint -o "$o" "$op" "${!c:-red}" "$s"
}
fll ()  { printf "%0.s${2:- }" $(seq 1 "${1:-1}"); }
flll () { 
  local n="$1";n=$((n-1))
  local tx;tx="$(printf "%0.s${2:- }" $(seq 1 "$n"))"
  pastel paint "${3:-$C00}" "$tx"
}
fill () {
  local cols;cols=$(tput cols)

  local o       ; o="${1:-1}"
  local l       ; l="${2:-10}"
  local s       ; s="${3:- }"
  local c       ; c="${4:-grey}"
  local b       ; b="${5:-$XBG}"
  local n       ; n=$((( (cols/2-${#3})-l)+o)); (( n < 0 )) && n="$o"
  local _filler ; _filler=$(printf "%0.s$s" $(seq 1 "$((n/${#s}))"))

  pastel paint "${c}" -o "${b}" -n "$_filler"
}
fillHead () { 
  local s=" ${1:-} "
  local slen=$((${#s}))
  local sep='╺╸·╺╸'
  local cols;  cols=$(tput cols)
  local space; space=$((( cols/2 - slen/2 )))
  fill $space "$cols" "$sep" "$XFG"
  pastel paint -n -o "$XBG" -b "${XFG}" "$s"
  fill $space "$(( cols + ${#sep} ))" "$sep" "$XFG"; pl '-'
}
fillCols () { 
  fill "$(($(tput cols)/2))" 0 "${1:-}" "${SK3}"
  pl '-'
} 

# "$(tput cols)" "${1:-·}" "${2:-$C00}"; }
# fillCols () { pl "$(tput cols)" "${1:-·}" "${2:-$C00}"; }
#
prntlist () {
  fname="${1%:*}"
  spmap="${1##*:}"

  sp_begin="${spmap}_begin"
  sp_middl="${spmap}_middl"
  sp_close="${spmap}_close"
  shift
  list=("$@")
  for i in "${!list[@]}"; do 
    if (( i == 0 )); then  
      $fname "${list[$i]}" "${!sp_begin}"
      continue
    fi
    if (( i + 1 == ${#list[@]} )); then 
      $fname "${list[$i]}" "${!sp_close}"
      continue
    fi

    $fname "${list[$i]}" "${!sp_middl}"
  done
}

MXSep () { pastel paint -n -b "$C08" "${1:-⏽}"; }

get_header () {
  local comment_char="${1:-#}"
  local header="{2:-MXCOLR}"
  if  command -v figlet &> /dev/null; then
    if [ -d /usr/share/figlet/fonts ]; then
      # header=$(figlet MXC -f "$(basename "$(find /usr/share/figlet/fonts -name '*.flf' | shuf -n 1)")" 2>/dev/null)
      header=$(figlet 'MXC' -p -f "$(figlist | shuf -n 1)" 2>/dev/null)
    else
      header=$(figlet "MXC" 2>/dev/null)
    fi
  fi
  local name="$MXNAME @ $MXC_V"; local _f=$(( ${#name} / 2 + 2 ))
  asciiart="$header"

  if ! (( "$3" )); then 
      asciiart="$(sed "s/^.*/${comment_char}&/p" <<< "$header")"
  fi
  asciiart="$(sed "s/[[:graph:]]/${comment_char}/g" <<< "$asciiart")"
  asciiart+="
  ${comment_char} ${name}"
  echo "$asciiart"
# $(printf "%0.s${comment_char}" $(seq 1 $_f))"
}

put_header () {
  local des="$1"; shift
  local esc="${1:-·}" 
  header=$(get_header "$esc" "MXC" 1)
  echo "local header = {" > "$des"
  while read -r i
  do
    echo "\"$i\"," >> "$des"
  done <<< "$header"

  echo "}" >> "$des"
  echo "return header" >> "$des"
}

Lorem () {
  local s=''
  for t in $(seq 1 "${1:-300}"); do
    (( RANDOM % 2 )) &&  s+="${2:-▂}"  ||  s+=' '
  done
  pastel paint "${C05}" "$s"
}

LoremCols () {
  Lorem "$(tput cols)" $1
}

