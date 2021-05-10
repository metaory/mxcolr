#!/usr/bin/env bash

Info () {
  local ico; local fc; local cc
  case "$2" in
    0) ico=''; fc="$DK7" ; cc="$C02" ;;
    1) ico=''; fc="$DK6" ; cc="$C01" ;;
    2) ico=''; fc="$DL5" ; cc="$DL8" ;;
    3) ico=''; fc="$DK5" ; cc="$DL5" ;;
    *) ico=''; fc="$DK6" ; cc="$DL5" ;;
  esac
  local s="$1"
  local sf; sf="${4:-$(basename "${BASH_SOURCE[1]}")}"; sf="${sf::(-3)}"
  sf="${sf:0:6}"
  local fn; fn="${3:-${FUNCNAME[1]}}"
  fn="${fn:0:12}"
  local src="${sf} ${fn}"

  local fill_len; fill_len=$((19-${#src}))
  local fill; fill="$(printf '%0.s ' $(seq 1 ${fill_len}))"

  pastel paint -b -n -o 'black' "${fc}" "[${src}]"
  pastel paint -b -n    "$cc"   "${fill}${s}"
  pastel paint -b       "$cc"   " ${ico} "
}

InfoIgnore () {
  Info " Ignoring·" 3 "${FUNCNAME[1]}" "$(basename "${BASH_SOURCE[1]}")"
}

InfoSourced () {
  Info "   $1" 2 "${FUNCNAME[1]}" "$(basename "${BASH_SOURCE[1]}")"
}

PressToContinue () {
  if [[ "$XOPT" == *"full"* ]]; then return; fi
  [ -n "$1" ] && pastel paint "${C03:-yellow}" -b " [ $1 ] "
  local fn; fn="${FUNCNAME[1]}"
  pastel paint -b -n -o 'black' "$WBX" "[${fn}]"
  pastel paint -b -n "$C03"   " continue"
  pastel paint -b -n "$C01"   "  "; MXDots; MXSep; pl
  if [[ "$XOPT" = full ]]; then REPLY='y'; pl '-'; return; fi
  read -n 1 -r -s
  pl '-'
}

BG_Sep () { 
local s; s=''
[[ -n "$1" ]] && s='█'
pastel paint -n -o "${2:-$DK0}" "${1:-$XBG}" "$s"
}
PrompRand () {
  pastel paint -n    -o "$WBG" "$C00" "  "  ; BG_Sep "$WBG"                              ; BG_Sep
  pastel paint -n -b -o "$DK0" "$C05" " [k]" ; pastel paint -n -o "$DK0" "$C07" "eep "    ; BG_Sep
  pastel paint -n -b -o "$DK0" "$C02" " [R]" ; pastel paint -n -o "$DK0" "$C07" "evert "  ; BG_Sep
  pastel paint -n -b -o "$DK0" "$C01" " [u]" ; pastel paint -n -o "$DK0" "$C07" "update " ; BG_Sep
  pastel paint -n -b -o "$DK0" "$C03" " [n]" ; pastel paint -n -o "$DK0" "$C07" "ext "    ; BG_Sep
  pastel paint -n -b -o "$DK0" "$C06" " [d]" ; pastel paint -n -o "$DK0" "$C07" "emo"     ; BG_Sep "$DK0" "$XBG"
  read -n 1 -r -s
  pastel paint -o "$SBG" "$SFG" -b " $REPLY "
}

PromptConfirm () {
  if [[ "$XOPT" = full ]]; then REPLY='y'; return; fi
  local msg; msg="${1:-Are you sure?}"
  pastel paint "$WBG" -n "${msg^} "
  pastel paint "$SBG" -n -b "[y/N] "
  read -n 1 -r; pl; if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  pastel paint -o "$C00" "$CX2" -b "  ·  "; else
  pastel paint -o "$C00" "$CX3" -b "  ·  "; fi
}
PromptContinue () {
  local fn; fn="${FUNCNAME[1]}"

  local fill_len; fill_len=$((20-${#fn}))
  local fill; fill="$(printf '%0.s ' $(seq 1 ${fill_len}))"

  pastel paint -b -n -o 'black' "$EBG" "[${fn}]"
  pl 'C01' "${fill}"
  PromptConfirm "   "
}
