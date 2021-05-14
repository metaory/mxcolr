#!/usr/bin/env bash

Info () {
  local ico; local cf; local cc; # ; local lvl=$1 # ; local on
  # ! [[ $2 =~ ^[0-9]+$ ]] && lvl=0
  case "${1:-0}" in
    0) ico='' ; cf="$SBG" ; cc="$C02" ;; # ; on="${3:-}" ; shift ;  ;
    1) ico='' ; cf="$C01" ; cc="$C01" ;;
    2) ico='' ; cf="$SBG" ; cc="$C07" ;;
    3) ico='' ; cf="$WBG" ; cc="$C08" ;;
    *) ico='' ; cf="$EBG" ; cc="$C15" ;;
  esac; shift

  local in="${1:-${BASH_SOURCE[1]}}" ; [[ "$VERBOSE" ]] && ! [[ "$in" =~ ^[0-9]+$ ]] && [[ -n "$in" ]] && pastel paint "$C07" " => ${in}"
  local fn="${2:-${FUNCNAME[1]}}"    ; #fn="${fn:(-8)}"
  local sf="${3:-${BASH_SOURCE[1]}}" ; sf="${sf:(-8)}" ; #sf="${sf:(-8)}"

  local src="${sf} ${fn}"
  local fill_len ; fill_len=$((19-${#src}))
  local fill     ; fill="$(printf '%0.s ' $(seq 1 ${fill_len}))"

  pastel paint -b -n -o 'black' "${cf}" "[${src}]"
  pastel paint -b -n    "$cc"   "${fill}${1##*/}"
  pastel paint -b       "$cc"   " ${ico} "
}

InfoIgnore () {
  Info 3 " Ignoring·" "${FUNCNAME[1]}" "$(basename "${BASH_SOURCE[1]}")"
}

InfoDone () {
  # mlg "1 $1"
  # mlg "BASH_SOURCE ${BASH_SOURCE[1]}"
  Info 0 "${1:-${BASH_SOURCE[1]}} " "${FUNCNAME[1]}" "$(basename "${BASH_SOURCE[1]}")"
}

PressToContinue () {
  if [[ "$XOPT" == *"full"* ]]; then return; fi
  [ -n "$1" ] && pastel paint "${C03:-yellow}" -b " [ $1 ] "
  local fn; fn="${FUNCNAME[1]}"
  pastel paint -b -n -o 'black' "$WBX" "[${fn}]"
  pastel paint -b -n "$C03"   " press any key to continue"
  pastel paint -b -n "$C01"   "  "; MXDots; MXSep; pl
  if [[ "$XOPT" = full ]]; then REPLY='y'; pl '-'; return; fi
  read -n 1 -r -s
  pl '-'
}

BG_Sep () { 
local s; s=''
[[ -n "$1" ]] && s='█'
pastel paint -n -o "${2:-black}" "${1:-$XBG}" "$s"
}
PrompRand () {
  pastel paint -n    -o "$WBG" "$WFG" "  "  ; BG_Sep "$WBG"                              ; BG_Sep
  pastel paint -n -b -o "black" "$C05" " [k]" ; pastel paint -n -o "black" "$C07" "eep "    ; BG_Sep
  pastel paint -n -b -o "black" "$C02" " [R]" ; pastel paint -n -o "black" "$C07" "evert "  ; BG_Sep
  pastel paint -n -b -o "black" "$C01" " [u]" ; pastel paint -n -o "black" "$C07" "update " ; BG_Sep
  pastel paint -n -b -o "black" "$C03" " [n]" ; pastel paint -n -o "black" "$C07" "ext "    ; BG_Sep
  pastel paint -n -b -o "black" "$C06" " [d]" ; pastel paint -n -o "black" "$C07" "emo"     ; BG_Sep "black" "$XBG"
  read -n 1 -r -s
  pastel paint -o "$XBG" "$SBG" -b -n "█"
  pastel paint -o "$SBG"  "$SFG" -b -n "$REPLY"
  pastel paint -o "$XBG" "$SBG" -b    "█"
}

PromptConfirm () {
  if [[ "$XOPT" = full ]]; then REPLY='y'; return; fi
  local msg; msg="${1:-Are you sure?}"
  pastel paint "$WBG" -n "${msg^} "
  pastel paint "$SBG" -n -b "[y/N] "
  read -n 1 -r; pl; if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  pastel paint -o "$C00" "$CX2" -b "  ·  "; else
  pastel paint -o "$C00" "$CX3" -b "  ·  "; fi
}
PromptContinue () {
  local fn; fn="${FUNCNAME[1]}"

  local fill_len; fill_len=$((20-${#fn}))
  local fill; fill="$(printf '%0.s ' $(seq 1 ${fill_len}))"

  pastel paint -b -n -o 'black' "$EBG" "[${fn}]"
  pl 'C01' "${fill}"
  PromptConfirm "   "
}
