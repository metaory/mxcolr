#!/usr/bin/env bash

_info () {
  local ico; local cf; local cc; # ; local lvl=$1 # ; local on
  # ! [[ $2 =~ ^[0-9]+$ ]] && lvl=0
  mlg "$*"
  case "${1:-0}" in
    0) ico=' ' ; cc="$C02" ;;
    1) ico='' ; cc="$C01" ;;
    2) ico='' ; cc="$C07" ;;
    3) ico='' ; cc="$C08" ;;
    *) ico='' ; cc="$C03" ;;
  esac         ; shift
  cf="${C07:-#f00}"; cc="${cc:-#ff0}"

  local in="${1:-${BASH_SOURCE[2]}}" ; [[ "$VERBOSE" ]] && ! [[ "$in" =~ ^[0-9]+$ ]] && [[ -n "$in" ]] && pastel paint "$C07" " => ${in}"
  local fn="${2:-${FUNCNAME[2]}}"    ; #fn="${fn:(-8)}"
  local sf="${3:-${BASH_SOURCE[2]}}" ; sf="${sf:(-8)}" ; #sf="${sf:(-8)}"

  local src="${sf} ${fn}"
  local fill_len ; fill_len=$((19-${#src}))
  local fill     ; fill="$(printf '%0.s ' $(seq 1 ${fill_len}))"

  pastel paint -b -n -o 'black' "${cf}" "[${src}]"
  pastel paint -b -n    "$cc"   "${fill}${1##*/}"
  pastel paint -b       "$cc"   " ${ico} "
}

InfoDone ()   { _info 0 "$*"               ; }
InfoError ()  { _info 1 "$*"               ; }
Info ()       { _info 2 "$*"               ; }
InfoIgnore () { _info 3 " Ignoring·" "$*" ; }
InfoWarn ()   { _info 4 "$*"               ; }

PressToContinue () {
  if [[ "$XOPT" == *"full"* ]]; then return; fi
  [ -n "$1" ] && pastel paint "${SBG:-yellow}" -b " [ $1 ] $2"
  local fn; fn="${FUNCNAME[1]}"
  pastel paint -b -n -o 'black' "$WBX" "[${fn}]"
  pastel paint -b -n "$C03"   " press any key to continue"
  pastel paint -b -n "$C01"   "  "; MXDots; MXSep; pl
  if [[ "$XOPT" = full ]]; then REPLY='y'; pl '-'; return; fi
  read -n 1 -r -s
  pl '-'
}

_slant_sep () { local s; s=''; [[ -n "$1" ]] && s='█'; pastel paint -n -o "${2:-black}" "${1:-$XBG}" "$s"; }

PrompRand () {
  pastel paint -n    -o "$WBG" "$WFG" "  "   ; _slant_sep "$WBG"                           ; _slant_sep
  pastel paint -n -b -o "black" "$C05" " [k]" ; pastel paint -n -o "black" "$C07" "eep "    ; _slant_sep
  pastel paint -n -b -o "black" "$C02" " [R]" ; pastel paint -n -o "black" "$C07" "evert "  ; _slant_sep
  pastel paint -n -b -o "black" "$C01" " [u]" ; pastel paint -n -o "black" "$C07" "update " ; _slant_sep
  pastel paint -n -b -o "black" "$C03" " [n]" ; pastel paint -n -o "black" "$C07" "ext "    ; _slant_sep
  pastel paint -n -b -o "black" "$C06" " [d]" ; pastel paint -n -o "black" "$C07" "emo"     ; _slant_sep "black" "$XBG"
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

  pastel paint -b -n "${C07:-#666}" "[ "
  pastel paint -b -n "${C08:-#666}" "${2##*/} "
  pastel paint -b -n "${C03:-#f66}" "${1:-${FUNCNAME[1]}}"
  pastel paint -b -n "${C07:-#666}" " ${3##*/}"
  pastel paint -b -n "${C07:-#666}" " ] ==> "
  PromptConfirm "   continue $1 " 
}
