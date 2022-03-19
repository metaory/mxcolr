#!/usr/bin/env bash

################################
MIN_HUE_DISTANCE=40
ATTMP_WARN_THRESHOLD=7
################################
_format () { pastel format $*; }
_formathex () { pastel format hex $*; }
_textcolor () { pastel textcolor $*; }
_saturate () { pastel saturate $*; }
_desaturate () { pastel desaturate $*; }
_saturation () { pastel set hsl-saturation  $*; }
_lightness () { pastel set hsl-lightness  $*; }
_lighten () { pastel lighten $*; }
_darken () { pastel darken $*; }
################################
_diff_real () { echo "df=($1 - $2); if (df < 0) { df=df* -1}; print df" | bc -l; }
################################

sort_lightness () {
  local H=0;local highest
  local L=100;local lowest

  while [ "$1" ]; do
    local l; l=$(_format lch-lightness "${!1}")
    (( $(echo "$l < $L" | bc) )) && L="$l" && lowest="$1"
    (( $(echo "$l > $H" | bc) )) && H="$l" && highest="$1"
    shift
  done

  echo "$highest:$lowest"
}

expandp () {
  while [ "$1" ]; do
    _format hex "${!1}"
    shift
  done
}
################################
lightest () {
  local l; l=$(sort_lightness "$@" | cut -d':' -f1)
  pastel paint "$(_textcolor "${!l}")" -o "${!l}" "${l}"
}
################################
darkest () {
  local d; d=$(sort_lightness "$@" | cut -d':' -f2)
  pastel paint "$(_textcolor "${!d}")" -o "${!d}" "${d}"
}

# shellcheck disable=SC2034
gen_random () {
  local attmp="${1:-1}"
  local strategy="${XOPT:-lch}" ; [[ "$strategy" == 'lch' ]] && strategy='lch_hue'
  local redo=0

  local seeds=( SBG WBG EBG )

  local randoms=( $(pastel random -n 3 -s "$strategy" | pastel sort-by chroma | _formathex) )

  for seed_id in ${!seeds[@]}; do
    local seed=${seeds[$seed_id]}

    declare -g "$seed=${randoms[$seed_id]}"

    local pre
    (( seed_id )) &&
      pre="${seeds[((seed_id - 1))]}" ||
      pre="${seeds[((${#seeds} - 1))]}"

    local curChroma=$(_format lch-chroma ${!seed})
    local curLightness=$(_format lch-lightness ${!seed})
    local curHue=$(_format lch-hue ${!seed})
    local preHue=$(_format lch-hue ${!pre})
    local diffHue; diffHue=$(_diff_real "$curHue" "$preHue")

    # Chroma boundaries
    (( $(echo "$curChroma > 80" | bc) )) &&
      declare -g "${seed}=$(pastel set chroma 60 ${!seed} | _formathex)"

    # Lightness boundaries
    (( $(echo "$curLightness > 70" | bc) )) &&
      declare -g "${seed}=$(pastel set lightness 60 ${!seed} | _formathex)"

    # Hue Distance boundaries
    (( $(echo "$diffHue < $MIN_HUE_DISTANCE" | bc -l) )) && redo=1
  done

  if (( redo )); then
    ! (( attmp % ATTMP_WARN_THRESHOLD )) && PressToContinue "failed $attmp attempts, still continue?"
    gen_random $((++attmp))
  else
    declare -g "TOTAL_ATTEMPTS=$attmp"
    fillCols ' ▪'; InfoDone "${strategy^^} generated, after $attmp attempts,proceeding"
    return
  fi
 }

gen_idempotents () {
  local ds;ds=$(darkest SBG WBG EBG)

  C01="$(pastel mix ${!ds} Crimson   -f 0.5 | pastel mix - PaleVioletRed     -f 0.4 | _saturate 0.04 | _formathex)"
  C02="$(pastel mix ${!ds} Teal      -f 0.5 | pastel mix - MediumSpringGreen -f 0.4 | _saturate 0.04 | _formathex)"
  C03="$(pastel mix ${!ds} Yellow    -f 0.5 | pastel mix - Coral             -f 0.4 | _saturate 0.04 | _formathex)"
  C04="$(pastel mix ${!ds} RoyalBlue -f 0.5 | pastel mix - DodgerBlue        -f 0.4 | _saturate 0.04 | _formathex)"
  C05="$(pastel mix ${!ds} Plum      -f 0.5 | pastel mix - SlateBlue         -f 0.4 | _saturate 0.04 | _formathex)"
  C06="$(pastel mix ${!ds} Cyan      -f 0.5 | pastel mix - DeepSkyBlue       -f 0.4 | _saturate 0.04 | _formathex)"

  for i in {09..14}; do
    local c="C0$(echo "$i - 8" | bc)"; c="${!c}"
    declare -g "C$i=$(_lighten 0.10 "$c" | _formathex)"
  done

  WBX="$(_saturate  0.30 "$WBG" | _lighten 0.10 | _formathex)"
  WFX="$(_textcolor      "$WBX" | _darken 0.20  | _formathex)"

  for i in {1..6}; do
    local c="C0$i"; c="${!c}"
    declare -g "CX$i=$(_saturate   0.30 "$c" | _darken  0.02 | _formathex)"
    declare -g "CY$i=$(_desaturate 0.30 "$c" | _lighten 0.10 | _formathex)"

    local cx="CX$i"; cx="${!cx}"
    declare -g "CF$i=$(_textcolor $cx | _formathex)"
  done

  for s in S W E; do
    local c="${s}BG"; c="${!c}"
    declare -g "${s}FG=$(_textcolor $c | _darken 0.2 | _saturate 0.20 | _formathex)"
  done

  InfoDone
} 

__gen_shade () {
  local c="${!1}";
  local k="${1:0:1}";

  declare -g "${k}K0=$(_saturation 0.10 "${c}" | _lightness 0.04 | _formathex)"
  declare -g "${k}K1=$(_saturation 0.11 "${c}" | _lightness 0.08 | _formathex)"
  declare -g "${k}K2=$(_saturation 0.12 "${c}" | _lightness 0.12 | _formathex)"
  declare -g "${k}K3=$(_saturation 0.13 "${c}" | _lightness 0.16 | _formathex)"
  declare -g "${k}K4=$(_saturation 0.14 "${c}" | _lightness 0.20 | _formathex)"
  declare -g "${k}K5=$(_saturation 0.14 "${c}" | _lightness 0.30 | _formathex)"
  declare -g "${k}K6=$(_saturation 0.13 "${c}" | _lightness 0.50 | _formathex)"
  declare -g "${k}K7=$(_saturation 0.12 "${c}" | _lightness 0.60 | _formathex)"
  declare -g "${k}K8=$(_saturation 0.11 "${c}" | _lightness 0.70 | _formathex)"
  declare -g "${k}K9=$(_saturation 0.10 "${c}" | _lightness 0.80 | _formathex)"
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

