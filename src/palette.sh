#!/usr/bin/env bash

################################
GEN_MIN_DISTANCE=30
ATTMP_WARN_THRESHOLD=7
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
  echo "1 $1"
  while [ "$1" ]; do
    pastel format hex "${!1}"
    shift
  done
}
################################
lightest () {
  local l; l=$(sort_lightness "$@" | cut -d':' -f1)
  pastel paint "$(pastel textcolor "${!l}")" -o "${!l}" "${l}"
}
################################
darkest () {
  local d; d=$(sort_lightness "$@" | cut -d':' -f2)
  pastel paint "$(pastel textcolor "${!d}")" -o "${!d}" "${d}"
}
################################

# shellcheck disable=SC2034
gen_random () {
  local attmp="${1:-1}"

  # PressToContinue "XOPT $XOPT"
  local strategy="${XOPT:-lch}" ; [[ "$strategy" == 'lch' ]]   && strategy='lch_hue'
  local xcal='0.16'             ; [[ "$strategy" == 'vivid' ]] && xcal='0.08'

  WBG="$(pastel random -n 1 -s "$strategy" | pastel saturate     "$xcal" | pastel darken "$xcal" | pastel format hex)"
  SBG="$(pastel random -n 1 -s "$strategy" | pastel mix - "$WBG" -f 0.80 | pastel darken "$xcal" | pastel format hex)"
  EBG="$(pastel random -n 1 -s "$strategy" | pastel mix - "$WBG" -f 0.80 | pastel darken "$xcal" | pastel format hex)"

  local WBG_SAT; WBG_SAT="$(pastel format hsl-saturation "$WBG")"
  local SBG_SAT; SBG_SAT="$(pastel format hsl-saturation "$SBG")"
  local EBG_SAT; EBG_SAT="$(pastel format hsl-saturation "$EBG")"

  mlg "S1:: S $SBG_SAT - W $WBG_SAT - E $EBG_SAT"
  (( $(echo "$SBG_SAT < 0.60" | bc) )) && SBG="$(pastel saturate 0.20 "$SBG" | pastel format hex)"
  (( $(echo "$EBG_SAT < 0.60" | bc) )) && EBG="$(pastel saturate 0.20 "$EBG" | pastel format hex)"
  mlg "S2:: S $SBG_SAT - W $WBG_SAT - E $EBG_SAT"

  mlg "$(pastel format hsl-saturation "$SBG") $(pastel format hsl-saturation "$EBG")"

  local WBG_HUE; WBG_HUE="$(pastel format hsl-hue "$WBG")"
  local SBG_HUE; SBG_HUE="$(pastel format hsl-hue "$SBG")"
  local EBG_HUE; EBG_HUE="$(pastel format hsl-hue "$EBG")"

  local S_fail;S_fail="$(diff_under "$WBG_HUE" "$SBG_HUE")"
  local E_fail;E_fail="$(diff_under "$WBG_HUE" "$EBG_HUE")"
  local X_fail;X_fail="$(diff_under "$SBG_HUE" "$EBG_HUE")"
  mlg "HU:: S $SBG_HUE - W $WBG_HUE - E $EBG_HUE"
  mlg "HX:: S $S_fail - E $E_fail - X $X_fail"

  if (( S_fail || E_fail || X_fail )); then
    ! (( attmp % ATTMP_WARN_THRESHOLD )) && PressToContinue "failed $attmp attempts, still continue?"
    gen_random $((++attmp))
  else
    fillCols ' ▪'; InfoDone "${strategy^^} generated, after $attmp attempts,proceeding"; return
  fi
}
# well almost!
gen_idempotents () {
  C01="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - crimson       -f 0.6 | pastel mix - deeppink          -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C02="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - darkseagreen  -f 0.6 | pastel mix - mediumspringgreen -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C03="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - orange        -f 0.6 | pastel mix - coral             -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C04="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - blue          -f 0.6 | pastel mix - deepskyblue       -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C05="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - indigo        -f 0.6 | pastel mix - slateblue         -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C06="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - darkturquoise -f 0.6 | pastel mix - deepskyblue       -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  # PressToContinue "[${FUNCNAME[0]}]__C05__${C05}"
  # echo '::::0::::'

  # C09="$(pastel lighten   0.10 "$C01" | pastel format hex)"; # 1
  # C10="$(pastel lighten   0.10 "$C02" | pastel format hex)"; # 2
  # C11="$(pastel lighten   0.10 "$C03" | pastel format hex)"; # 3
  # C12="$(pastel lighten   0.10 "$C04" | pastel format hex)"; # 4
  # C13="$(pastel lighten   0.10 "$C05" | pastel format hex)"; # 5
  # C14="$(pastel lighten   0.10 "$C06" | pastel format hex)"; # 6
  for i in {09..14}; do
    local c="C0$(echo "$i - 8" | bc)"; c="${!c}"
    declare -g "C$i=$(pastel lighten   0.10 "$c" | pastel format hex)"
  done

  WBX="$(pastel saturate  0.30 "$WBG" | pastel lighten 0.10  | pastel format hex)" ; # ZXX
  WFX="$(pastel textcolor      "$WBX" | pastel darken  0.20  | pastel format hex)" ; # ZXF

  # __print_hexes $(echo CX{1..6})
  # CX1="$(pastel saturate  0.25 "$C01" | pastel lighten  0.02 | pastel format hex)" ; # C01
  # CX2="$(pastel saturate  0.25 "$C02" | pastel lighten  0.02 | pastel format hex)" ; # C02
  # CX3="$(pastel saturate  0.25 "$C03" | pastel lighten  0.02 | pastel format hex)" ; # C03  
  # CX4="$(pastel saturate  0.25 "$C04" | pastel lighten  0.02 | pastel format hex)" ; # C04
  # CX5="$(pastel saturate  0.25 "$C05" | pastel lighten  0.06 | pastel format hex)" ; # C05
  # CX6="$(pastel saturate  0.25 "$C06" | pastel lighten  0.02 | pastel format hex)" ; # C06
  for i in {1..6}; do
    local c="C0$i"; c="${!c}"
    declare -g "CX$i=$(pastel saturate  0.20 "$c"   | pastel lighten  0.02 | pastel format hex)"
    declare -g "CY$i=$(pastel desaturate  0.16 "$c" | pastel lighten  0.06 | pastel format hex)"
  done
  # __print_hexes $(echo CX{1..6})


  WFG="$(pastel textcolor "$WBG" | pastel darken 0.2 | pastel format hex)"
  EFG="$(pastel textcolor "$EBG" | pastel darken 0.2 | pastel saturate 0.20 | pastel format hex)"
  SFG="$(pastel textcolor "$SBG" | pastel darken 0.2 | pastel saturate 0.20 | pastel format hex)"

  InfoDone
} 

# shellcheck disable=SC2034
gen_shades () {
  local darkestSeed;darkestSeed=$(darkest SBG WBG EBG)
  pastel paint -b -o "${!darkestSeed}" "$(pastel textcolor "${!darkestSeed}")" " darkest seed : ${darkestSeed} "
  XBG="$(pastel set hsl-saturation   0.18 "${!darkestSeed}" | pastel set hsl-lightness 0.06 | pastel format hex)"
  OBG="$(pastel lighten 0.08 "$XBG" |  pastel saturate 0.04 | pastel format hex)"; # OBG="$(pastel desaturate  0.20 "$WBG" | pastel darken  0.30        | pastel format hex)"
  DKB="$(pastel lighten 0.10 "$XBG" | pastel   saturate 0.04 | pastel format hex)"; # OBG="$(pastel desaturate  0.20 "$WBG" | pastel darken  0.30        | pastel format hex)"



#   DL0="$(pastel darken  0.02 "$XBG" | pastel saturate 0.0  | pastel format hex)"
#   DL1="$(pastel lighten 0.04 "$XBG" | pastel saturate 0.10 | pastel format hex)"
#   DL2="$(pastel lighten 0.08 "$XBG" | pastel saturate 0.20 | pastel format hex)"
#   DL3="$(pastel lighten 0.10 "$XBG" | pastel saturate 0.20 | pastel format hex)"
#   DL4="$(pastel lighten 0.20 "$XBG" | pastel saturate 0.20 | pastel format hex)"
#   DL5="$(pastel lighten 0.30 "$XBG" | pastel saturate 0.20 | pastel format hex)"
#   DL6="$(pastel lighten 0.40 "$XBG" | pastel saturate 0.30 | pastel format hex)"
#   DL7="$(pastel lighten 0.50 "$XBG" | pastel saturate 0.30 | pastel format hex)"
#   DL8="$(pastel lighten 0.60 "$XBG" | pastel saturate 0.40 | pastel format hex)"
#   DL9="$(pastel lighten 0.80 "$XBG" | pastel saturate 0.40 | pastel format hex)"
# 
#   DK0="$(pastel darken  0.14 "$DKB" | pastel saturate 0.20 | pastel format hex)"
#   DK1="$(pastel darken  0.10 "$DKB" | pastel saturate 0.16 | pastel format hex)"
#   DK2="$(pastel darken  0.06 "$DKB" | pastel saturate 0.12 | pastel format hex)"
#   DK3="$(pastel darken  0.00 "$DKB" | pastel saturate 0.04 | pastel format hex)"
#   DK4="$(pastel lighten 0.06 "$DKB" | pastel saturate 0.07 | pastel format hex)"
#   DK5="$(pastel lighten 0.12 "$DKB" | pastel saturate 0.06 | pastel format hex)"
#   DK6="$(pastel lighten 0.18 "$DKB" | pastel saturate 0.05 | pastel format hex)"
#   DK7="$(pastel lighten 0.26 "$DKB" | pastel saturate 0.04 | pastel format hex)"
#   DK8="$(pastel lighten 0.32 "$DKB" | pastel saturate 0.03 | pastel format hex)"
#   DK9="$(pastel lighten 0.38 "$DKB" | pastel saturate 0.02 | pastel format hex)"


  if (( "$DEBUG" )); then
    __print_hexes $(echo DK{1..9})
    __print_hexes $(echo DL{1..9})
    __print_hexes $(echo LK{1..9})
    Demo_shades4; echo
    printf '%10s %10s %10s %10s %10s %10s\n' "RL1" "L1" "L2" "RL2" "E1" "E2"
  fi

  # XBG="$(pastel set hsl-saturation   0.18 "${!darkestSeed}" | pastel set hsl-lightness 0.06 | pastel format hex)"
  # DKB="$(pastel lighten 0.10 "$XBG" | pastel   saturate 0.04 | pastel format hex)"; # OBG="$(pastel desaturate  0.20 "$WBG" | pastel darken  0.30        | pastel format hex)"

  for i in {0..9}               ; do

    local RL1="0$(echo "scale=2 ; ((9-$i) *  2 + 1) / 100" | bc)"
    local RL2="0$(echo "scale=2 ; e(a((9-$i)/2)) / 10"     | bc -l)"
    local E1="0$(echo "scale=2  ; ($i * $i+1) / 100"         | bc)"
    local E2="0$(echo "scale=2  ; e($i/2) / 100"           | bc -l)"

    local L1="0$(echo "scale=2  ; ($i *  2 + 1) / 100"     | bc)"
    local L2="0$(echo "scale=2  ; e(a($i-4/2)) / 10"       | bc -l)"
    local RE1="0$(echo "scale=2 ; 0.9 - $E1"               | bc)"

    local Act1=lighten
    local Act2=saturate

    # if (( $i < 3 )); then Act1=darken fi
    # if (( $i < 3 )); then E1="$RL1"; E2="$RL1"; fi

    declare -g "LK$i=$(pastel "$Act1" "$E2" "$XBG" | pastel "$Act1" "$RL1" | pastel format hex)"
    declare -g "DL$i=$(pastel "$Act1" "$E1" "$XBG" | pastel "$Act2" "$RL1" | pastel format hex)"
    declare -g "DK$i=$(pastel "$Act1" "$E2" "$XBG" | pastel "$Act2" "$RL2" | pastel format hex)"

    (( "$DEBUG" )) && printf '%10s %10s %10s  %10s %10s %10s\n' "$RL1" "$L1" "$L2" "$RL2"  "$E1" "$E2"
  done

  if (( "$DEBUG" )); then
    Demo_shades4
    __print_hexes $(echo DK{1..9})
    __print_hexes $(echo DL{1..9})
    __print_hexes $(echo LK{1..9})
  fi

  OFG="$WBX"
  C00="$DK2"
  C08="$DK4"
  C07="$DL5"
  XFG="$DL8"; # XFG="$(pastel lighten 0.20 "$DKB" | pastel desaturate 0.02 | pastel format hex)"
  C15="$DL9"

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

  SaveTheme
  InfoDone
}

# pastel format hex $C01 $C02 $C03 $C04 $C05


# printf '%10s %10s %10s %10s %10s\n' "S" "C" "A" "L" "E"
# for i in {0..9}; do
#   s="0$(echo "scale=4; s($i) / 100" | bc -l)"
#   c="0$(echo "scale=4; c($i) / 100" | bc -l)"
#   a="0$(echo "scale=4; a($i) / 100" | bc -l)"
#   l="0$(echo "scale=4; l($i) / 10 * 2" | bc -l)"
#   e="0$(echo "scale=3; e($i/2) / 100" | bc -l)"
#   printf '%10s %10s %10s %10s %10s\n' "$s" "$c" "$a" "$l" "$e"
# done

# printf '%10s %10s %10s %10s\n' "L1" "L2" "S1" "S2"
# printf '%10s %10s %10s %10s\n' "$l" "$light" "$s" "$satur"

# s (x)  The sine of x, x is in radians.
# c (x)  The cosine of x, x is in radians.
# a (x)  The arctangent of x, arctangent returns radians.
# l (x)  The natural logarithm of x.
# e (x)  The exponential function of raising e to the value x.
# j (n,x) The Bessel function of integer order n of x.

(( "$DEBUG" )) && gen_shades
# gen_shades
# gen_idempotents
# XXX
# local satur="0$(echo "scale=3; a($i+1) / 10 * 2" | bc -l)"
#       L1         L2         E1         E2
#       0.01       0.10       0.01       0.01
#       0.03       0.21       0.02       0.01
#       0.05       0.30       0.05       0.02
#       0.07       0.34       0.10       0.04
#       0.09       0.37       0.17       0.07
#       0.11       0.39       0.26       0.12
#       0.13       0.40       0.37       0.20
#       0.15       0.41       0.50       0.33
#       0.17       0.42       0.65       0.54
#       0.19       0.43       0.82       0.90
# 

  #     E1         E2         L1         L2
  #     0.01       0.01       0.01       0.10
  #     0.02       0.01       0.03       0.21
  #     0.05       0.02       0.05       0.30
  #     0.10       0.04       0.07       0.34
  #     0.17       0.07       0.09       0.37
  #     0.26       0.12       0.11       0.39
  #     0.37       0.20       0.13       0.40
  #     0.50       0.33       0.15       0.41
  #     0.65       0.54       0.17       0.42
  #     0.82       0.90       0.19       0.43


