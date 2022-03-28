#!/usr/bin/env bash

DEFAULT_TINT=${DEFAULT_TINT:-10}

_paint () { pastel paint -b "${2:-$WBG}" "${1:-NA}"; }
  # tput sc
_info () {
  local ico; local cf; local cc; # ; local lvl=$1 # ; local on
  # ! [[ $2 =~ ^[0-9]+$ ]] && lvl=0
  mlg "$*"
  case "${1:-0}" in
    0) ico=' ' ; cc="$C02" ;;
    1) ico='' ; cc="$C01" ;;
    2) ico='' ; cc="$C07" ;;
    3) ico='' ; cc="$C05" ;;
    *) ico='' ; cc="$C03" ;;
  esac         ; shift
  cf="${C07:-#f00}"; cc="${cc:-#ff0}"

  local in="${1:-${BASH_SOURCE[2]}}" ; [[ "$VERBOSE" ]] && ! [[ "$in" =~ ^[0-9]+$ ]] && [[ -n "$in" ]] && pastel paint "$C07" " => ${in}"
  local fn="${2:-${FUNCNAME[2]}}"    ; #fn="${fn:(-8)}"
  local sf="${3:-${BASH_SOURCE[2]}}" ; sf="${sf:(-8)}" ; #sf="${sf:(-8)}"

  local src="${sf} ${fn}"
  local fill_len ; fill_len=$((19-${#src}))
  local fill     ; fill="$(printf '%0.s ' $(seq 1 ${fill_len}))"

  # tput rc; tput el
  pastel paint -b -n -o 'black' "${cf}" "[${src}]"
  pastel paint -b -n    "$cc"   "${fill}${1##*/}"
  pastel paint -b       "$cc"   " ${ico} "
}

InfoDone ()   { _info 0 "$*"               ; }
InfoError ()  { _info 1 "$*"               ; }
Info ()       { _info 2 "$*"               ; }
InfoIgnore () { _info 3 " Ignoring·"; _paint " ==> ${*}" "$EBG"; }
InfoWarn ()   { _info 4 "$*"               ; }

PressToContinue () {
  if (( "$FORCE_UPDATE" )); then return; fi
  [ -n "$1" ] && pastel paint "${SBG:-yellow}" -b " [ $1 ] $2"
  local fn; fn="${FUNCNAME[1]}"
  pastel paint -b -n -o 'black' "$WBX" "[${fn}]"
  pastel paint -b -n "$C03"   " press any key to continue"
  pastel paint -b -n "$C01"   " ⋯ "; MXDots; MXSep; pl
  if (( "$FORCE_UPDATE" )); then REPLY='y'; pl '-'; return; fi
  read -n 1 -r -s
  pl '-'
}

_slant_sep () { local s; s=''; [[ -n "$1" ]] && s='█'; pastel paint -n -o "${2:-black}" "${1:-$XBG}" "$s"; }

PrompRand () {
  pastel paint -n    -o "$WBG" "$WFG" " ● "    ; _slant_sep "$WBG"                           ; _slant_sep
  pastel paint -n -b -o "black" "$C05" " [k]"  ; pastel paint -n -o "black" "$C07" "eep "    ; _slant_sep
  pastel paint -n -b -o "black" "$C02" " [*R]" ; pastel paint -n -o "black" "$C07" "evert "  ; _slant_sep
  pastel paint -n -b -o "black" "$C01" " [Uu]" ; pastel paint -n -o "black" "$C07" "pdate "  ; _slant_sep
  pastel paint -n -b -o "black" "$C04" " [s]"  ; pastel paint -n -o "black" "$C07" "huffle " ; _slant_sep
  pastel paint -n -b -o "black" "$C03" " [n]"  ; pastel paint -n -o "black" "$C07" "ext "    ; _slant_sep
  pastel paint -n -b -o "black" "$C06" " [d]"  ; pastel paint -n -o "black" "$C07" "emo"     ; _slant_sep "black" "$XBG"
  read -n 1 -r -s
  pastel paint -o "$XBG" "$SBG" -b -n "█"
  pastel paint -o "$SBG"  "$SFG" -b -n "$REPLY"
  pastel paint -o "$XBG" "$SBG" -b    "█"
}

PromptConfirm () {
  if (( "$FORCE_UPDATE" )); then REPLY='y'; return; fi
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

PromptWallpaperTint () {
  pastel paint -b -n -o 'black' "$WBX" "[${FUNCNAME[0]}]"
  pastel paint -b -n "$C03"   " enter Fill value [0-1000]"
  pastel paint -b -n "$C02"   " default:($DEFAULT_TINT) "
  (( "$FORCE_UPDATE" )) && REPLY="$DEFAULT_TINT" && return
  read -r
  [ -z "$REPLY" ] && REPLY="$DEFAULT_TINT"
  if ! [[ "$REPLY" =~ ^[0-9]+$ ]]; then 
    pastel paint -b -n -o "$C01" "black" "  $REPLY "
    pastel paint -b  "$C01" " numbers only "
    PromptWallpaperTint
  fi
}

PrintMenu () {
  (( "$DEBUG" )) && return
  cat <<  EOF
Usage
=====
    mxcolr [options] <action> [params]

Options
=======
    --force                 | forcefull update
    --verbose               | verbose logs
    --tmp-only              | exit silently after placing temp files in /tmp/mxc

Utilities
=========
    --gen-icon              | [char, path]; create image in path icon from the char
    --lorem                 | [length, char]; print char randomely for the length 
    --lorem-cols            | [char]; fill terminal column with char
    --darkest               | [colors]; return darkest color of the list
    --lightest              | [colors]; return lightest color of the list

Actions
=======
    -g, generate <strategy> | <vivid, lch> (Pastel randomization strategy) default is lch
    -u, update              | apply to all plugins
    -U, update-force        | force apply to all plugins without any prompts
    -d, demo                | basic demo
    -D, demo-all            | complete demo
    -l, list                | list all saved snapshots
    -r, random              | pick a random snapshot
    -s, save                | save snapshot
     *                      | intro

EOF

InfoDone
}
