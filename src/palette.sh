#!/usr/bin/env bash

################################
GEN_MIN_DISTANCE=20
ATTMP_WARN_THRESHOLD=7
################################
_fh () { pastel format hex $1; }
_tx () { pastel textcolor $1; }
_ss () { pastel saturate $1 $2; }
_ds () { pastel desaturate $1 $2; }
_dd () { pastel darken $1 $2; }
_ll () { pastel lighten $1 $2; }
_hs () { pastel set hsl-saturation  $1 $2; }
_hl () { pastel set hsl-lightness  $1 $2; }
################################
diff_real () { echo "df=($1 - $2); if (df < 0) { df=df* -1}; print df" | bc -l; }
diff_under () {
  local diff; diff=$(diff_real "$1" "$2")
  echo "$diff < $GEN_MIN_DISTANCE" | bc -l
}
################################

sort_lightness () {
  local H=0;local highest
  local L=100;local lowest

  while [ "$1" ]; do
    local l; l=$(pastel format lch-lightness "${!1}")
    (( $(echo "$l < $L" | bc) )) && L="$l" && lowest="$1"
    (( $(echo "$l > $H" | bc) )) && H="$l" && highest="$1"
    shift
  done

  echo "$highest:$lowest"
}

expandp () {
  while [ "$1" ]; do
    pastel format hex "${!1}"
    shift
  done
}
################################
lightest () {
  local l; l=$(sort_lightness "$@" | cut -d':' -f1)
  pastel paint "$(_tx "${!l}")" -o "${!l}" "${l}"
}
################################
darkest () {
  local d; d=$(sort_lightness "$@" | cut -d':' -f2)
  pastel paint "$(_tx "${!d}")" -o "${!d}" "${d}"
}

# shellcheck disable=SC2034
gen_random () { 
  local attmp="${1:-1}"
  local strategy="${XOPT:-lch}" ; [[ "$strategy" == 'lch' ]]   && strategy='lch_hue'
  local redo=0
  local seeds=( SBG WBG EBG )

  for seed in ${seeds[@]}; do declare -g "${seed}=$(pastel random -n 1 -s "$strategy" | _fh)"; done

  for seed_id in ${!seeds[@]}; do
    local seed=${seeds[$seed_id]}
    local preSeed
    [ "$seed_id" -eq 0 ] && preSeed=EBG || preSeed="${seeds[((seed_id - 1))]}"

    local curHue=$(pastel format lch-hue ${!seed})
    (( $(echo "$curHue < 50" | bc) )) && curHue="$(echo "$curHue + 300" | bc)"

    local preHue=$(pastel format lch-hue ${!preSeed})
    (( $(echo "$preHue < 50" | bc) )) && preHue="$(echo "$preHue + 300" | bc)"

    local hueDiffCheck;hueDiffCheck="$(diff_under "$curHue" "$preHue")"
    (( hueDiffCheck )) && redo=1
  done

  if (( redo )); then
    ! (( attmp % ATTMP_WARN_THRESHOLD )) && PressToContinue "failed $attmp attempts, still continue?"
    gen_random $((++attmp))
  else
    fillCols ' ▪'; InfoDone "${strategy^^} generated, after $attmp attempts,proceeding"; return
  fi
 }

gen_idempotents () {
  local ds;ds=$(darkest SBG WBG EBG)
  # local ds=SBG

  C01="$(pastel mix ${!ds} Crimson   -f 0.5 | pastel mix - HotPink           -f 0.4 | _ss 0.04 | _fh)"
  C02="$(pastel mix ${!ds} Teal      -f 0.5 | pastel mix - MediumSpringGreen -f 0.4 | _ss 0.04 | _fh)"
  C03="$(pastel mix ${!ds} Yellow    -f 0.5 | pastel mix - Coral             -f 0.4 | _ss 0.04 | _fh)"
  C04="$(pastel mix ${!ds} RoyalBlue -f 0.5 | pastel mix - DodgerBlue        -f 0.4 | _ss 0.04 | _fh)"
  C05="$(pastel mix ${!ds} Orchid    -f 0.5 | pastel mix - SlateBlue         -f 0.4 | _ss 0.04 | _fh)"
  C06="$(pastel mix ${!ds} Cyan      -f 0.5 | pastel mix - DeepSkyBlue       -f 0.4 | _ss 0.04 | _fh)"

  for i in {09..14}; do
    local c="C0$(echo "$i - 8" | bc)"; c="${!c}"
    declare -g "C$i=$(_ll 0.10 "$c" | _fh)"
  done

  WBX="$(_ss  0.30 "$WBG" | _ll 0.10 | _fh)"
  WFX="$(_tx "$WBX" | _dd 0.20 | _fh)"

  for i in {1..6}; do
    local c="C0$i"; c="${!c}"
    declare -g "CX$i=$(_ss 0.30 "$c" | _dd 0.02 | _fh)"
    declare -g "CY$i=$(_ds 0.25 "$c" | _ll 0.10 | _fh)"

    local cx="CX$i"; cx="${!cx}"
    declare -g "CF$i=$(_tx $cx | _fh)"
  done

  for s in S W E; do
    local c="${s}BG"; c="${!c}"
    declare -g "${s}FG=$(_tx $c | _dd 0.2 | _ss 0.20 | _fh)"
  done

  InfoDone
} 

__gen_shade () {
  local c="${!1}";
  local k="${1:0:1}";

  declare -g "${k}K0=$(_hs 0.10 "${c}" | _hl 0.04 | _fh)"
  declare -g "${k}K1=$(_hs 0.11 "${c}" | _hl 0.08 | _fh)"
  declare -g "${k}K2=$(_hs 0.12 "${c}" | _hl 0.12 | _fh)"
  declare -g "${k}K3=$(_hs 0.13 "${c}" | _hl 0.16 | _fh)"
  declare -g "${k}K4=$(_hs 0.14 "${c}" | _hl 0.20 | _fh)"
  declare -g "${k}K5=$(_hs 0.14 "${c}" | _hl 0.30 | _fh)"
  declare -g "${k}K6=$(_hs 0.13 "${c}" | _hl 0.50 | _fh)"
  declare -g "${k}K7=$(_hs 0.12 "${c}" | _hl 0.60 | _fh)"
  declare -g "${k}K8=$(_hs 0.11 "${c}" | _hl 0.70 | _fh)"
  declare -g "${k}K9=$(_hs 0.10 "${c}" | _hl 0.80 | _fh)"
}

# shellcheck disable=SC2034
gen_shades () {
  local darkest_seed;darkest_seed=$(darkest SBG WBG EBG)
  local k="${darkest_seed:0:1}";

  __gen_shade SBG
  __gen_shade WBG
  __gen_shade EBG

  C00="${k}K2"; C00="${!C00}"
  C08="${k}K5"; C08="${!C08}"
  C07="${k}K6"; C07="${!C07}"
  C15="${k}K8"; C15="${!C15}"

  XBG="${k}K1"; XBG="${!XBG}"
  XFG="${k}K6"; XFG="${!XFG}"

  OBG="${k}K4"; OBG="${!OBG}"
  OFG="${k}K7"; OFG="${!OFG}"

  InfoDone
}

# #################
################################
GeneratePalette () { 
  gen_random
  gen_idempotents
  gen_shades
  gen_ansi

  SaveSeed
  SaveTheme
  InfoDone
}
################################
################################
UpdatePalette () {
  . "$M_SEED" 2> /dev/null || . "$O_SEED"
  gen_idempotents
  gen_shades
  gen_ansi
  set_hexless

  # SaveSeed
  SaveTheme
  InfoDone
}

(( "$DEBUG" )) && gen_shades
# (( "$DEBUG" )) && gen_idempotents
# (( "$DEBUG" )) && Demo && Demo_slant && Demo_hexes
# if (( "$DEBUG" )); then 
#   __print_hexes $(echo SK{0..9})
#   __print_hexes $(echo WK{0..9})
#   __print_hexes $(echo EK{0..9})
#   Demo_shades4; echo
# fi

