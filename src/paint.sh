#!/usr/bin/env bash

export sp_block_l_begin='▌'
export sp_block_l_middl=''
export sp_block_l_close='▐'

export sp_pentagon_begin=''
export sp_pentagon_middl=''
export sp_pentagon_close=''

export sp_tiny_begin=' '
export sp_tiny_middl=' '
export sp_tiny_close=' '

export sp_blank_begin='  '
export sp_blank_middl='  '
export sp_blank_close='  '

export sp_block_l_begin=''
export sp_block_l_middl=''
export sp_block_l_close=''

export sp_block_c_begin='█'
export sp_block_c_middl=''
export sp_block_c_close='█'

export sp_block_d_begin='█'
export sp_block_d_middl='██'
export sp_block_d_close='█'

export sp_block_e_begin='▆ '
export sp_block_e_middl='▆ '
export sp_block_e_close='▆'

# export sp_block_begin=''
export sp_block_r_begin=''
export sp_block_r_middl=''
export sp_block_r_close=''

# export sp_line_top_begin='┏╸━'
# export sp_line_top_middl='━╸'
# export sp_line_top_close='━━╸━┓'
export sp_line_begin='╺╸'
export sp_line_middl='··'
export sp_line_close='·╺╸'

export sp_line_top_begin='┏╸'
export sp_line_top_middl='·'
export sp_line_top_close='·╺┓'
#   
export sp_cross_begin=' '
export sp_cross_middl=' '
export sp_cross_close=' '

export sp_dot_begin=' ●'
export sp_dot_middl=' '
export sp_dot_close=' ●'

export sp_lash_begin='●'
export sp_lash_middl='●'
export sp_lash_close='●●'

export sp_dotline_begin='╸⏽'
export sp_dotline_middl='●⏽'
export sp_dotline_close='╺'

export sp_lash_begin='╸⏽'
export sp_lash_middl='●⏽'
export sp_lash_close='●╺'

export sp_box_slant_begin='█┣╸●'
export sp_box_slant_middl=' '
export sp_box_slant_close=' ●╺┫█'

export sp_circle_slant_begin='█┣ ●'
export sp_circle_slant_middl=' '
export sp_circle_slant_close=' ● ┫█'

export sp_dot_slant_begin='█🮈╸'
export sp_dot_slant_middl='·'
export sp_dot_slant_close='·╺▍█'

export sp_line_top_mini_begin='┏╸'
export sp_line_top_mini_middl='·'
export sp_line_top_mini_close='·╺╺┓'

export sp_line_bot_begin='┗━╺╸╺╸'
export sp_line_bot_middl='╺━'
export sp_line_bot_close='┛'

export sp_line_bo2_begin='┗╸'
export sp_line_bo2_middl='╺╸'
export sp_line_bo2_close='┛'

export sp_box_begin='■'
export sp_box_middl='■'
export sp_box_close='■'

export sp_box2_begin='█🮈'
export sp_box2_middl='▍'
export sp_box2_close='▍█'

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\  
prnt (){
  char="${2:-}"
  pastel paint -o "$XBG" -n "${!1:-red}" "$char" 
}
pl () {
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
  local space; space=$((( cols/2 - slen/2 ) + ${#sep}))
  fill $space "$cols" "$sep" "$XFG"
  pastel paint -n -o "$XBG" -b "${XFG}" "$s"
  fill $space "$cols" "$sep" "$XFG"; pl '-'
}
fillCols () { fill $(($(tput cols)/2)) 0 '' "$C08"; pl '-'; } # "$(tput cols)" "${1:-·}" "${2:-$C00}"; }
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
