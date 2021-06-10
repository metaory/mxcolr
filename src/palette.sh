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

  local SOver;SOver="$(diff_under "$WBG_HUE" "$SBG_HUE")"
  local EOver;EOver="$(diff_under "$WBG_HUE" "$EBG_HUE")"
  local XOver;XOver="$(diff_under "$SBG_HUE" "$EBG_HUE")"
  mlg "HU:: S $SBG_HUE - W $WBG_HUE - E $EBG_HUE"
  mlg "HX:: S $SOver - E $EOver - X $XOver"

  if (( SOver || EOver || XOver )); then
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

  C09="$(pastel lighten   0.10 "$C01" | pastel format hex)"; # 1
  C10="$(pastel lighten   0.10 "$C02" | pastel format hex)"; # 2
  C11="$(pastel lighten   0.10 "$C03" | pastel format hex)"; # 3
  C12="$(pastel lighten   0.10 "$C04" | pastel format hex)"; # 4
  C13="$(pastel lighten   0.10 "$C05" | pastel format hex)"; # 5
  C14="$(pastel lighten   0.10 "$C06" | pastel format hex)"; # 6

  WBX="$(pastel saturate  0.30 "$WBG" | pastel lighten 0.10  | pastel format hex)" ; # ZXX
  WFX="$(pastel textcolor      "$WBX" | pastel darken  0.20  | pastel format hex)" ; # ZXF

  CX1="$(pastel saturate  0.25 "$C01" | pastel lighten  0.02 | pastel format hex)" ; # C01
  CX2="$(pastel saturate  0.25 "$C02" | pastel lighten  0.02 | pastel format hex)" ; # C02
  CX3="$(pastel saturate  0.25 "$C03" | pastel lighten  0.02 | pastel format hex)" ; # C03  
  CX4="$(pastel saturate  0.25 "$C04" | pastel lighten  0.02 | pastel format hex)" ; # C04
  CX5="$(pastel saturate  0.25 "$C05" | pastel lighten  0.06 | pastel format hex)" ; # C05
  CX6="$(pastel saturate  0.25 "$C06" | pastel lighten  0.02 | pastel format hex)" ; # C06

  WFG="$(pastel textcolor      "$WBG" | pastel darken 0.2 | pastel format hex)"
  EFG="$(pastel textcolor      "$EBG" | pastel darken 0.2 | pastel saturate 0.20 | pastel format hex)"
  SFG="$(pastel textcolor      "$SBG" | pastel darken 0.2 | pastel saturate 0.20 | pastel format hex)"

  InfoDone
} 

# shellcheck disable=SC2034
gen_shades () {
  XBG="$(pastel set hsl-saturation   0.14 "$WBG" | pastel set hsl-lightness 0.08 | pastel format hex)"
  OBG="$(pastel lighten 0.08 "$XBG" |  pastel saturate 0.04 | pastel format hex)"; # OBG="$(pastel desaturate  0.20 "$WBG" | pastel darken  0.30        | pastel format hex)"
  OFG="$WBX"
  DKB="$(pastel lighten 0.10 "$XBG" |  pastel saturate 0.04 | pastel format hex)"; # OBG="$(pastel desaturate  0.20 "$WBG" | pastel darken  0.30        | pastel format hex)"

  DL0="$(pastel darken  0.02 "$XBG" | pastel   saturate 0.0  | pastel format hex)"
  DL1="$(pastel lighten 0.04 "$XBG" | pastel   saturate 0.10 | pastel format hex)"
  DL2="$(pastel lighten 0.08 "$XBG" | pastel   saturate 0.20 | pastel format hex)"
  DL3="$(pastel lighten 0.10 "$XBG" | pastel   saturate 0.20 | pastel format hex)"
  DL4="$(pastel lighten 0.20 "$XBG" | pastel   saturate 0.20 | pastel format hex)"
  DL5="$(pastel lighten 0.30 "$XBG" | pastel   saturate 0.20 | pastel format hex)"
  DL6="$(pastel lighten 0.40 "$XBG" | pastel   saturate 0.30 | pastel format hex)"
  DL7="$(pastel lighten 0.50 "$XBG" | pastel   saturate 0.30 | pastel format hex)"
  DL8="$(pastel lighten 0.60 "$XBG" | pastel   saturate 0.40 | pastel format hex)"
  DL9="$(pastel lighten 0.70 "$XBG" | pastel   saturate 0.40 | pastel format hex)"

  DK0="$(pastel darken  0.14 "$DKB" | pastel   saturate 0.20 | pastel format hex)"                                                            
  DK1="$(pastel darken  0.10 "$DKB" | pastel   saturate 0.16 | pastel format hex)"                                                            
  DK2="$(pastel darken  0.06 "$DKB" | pastel   saturate 0.12 | pastel format hex)"                                                            
  DK3="$(pastel darken  0.00 "$DKB" | pastel   saturate 0.04 | pastel format hex)"                                                            
  DK4="$(pastel lighten 0.06 "$DKB" | pastel   saturate 0.07 | pastel format hex)"                                                            
  DK5="$(pastel lighten 0.12 "$DKB" | pastel   saturate 0.06 | pastel format hex)"                                                            
  DK6="$(pastel lighten 0.18 "$DKB" | pastel   saturate 0.05 | pastel format hex)"                                                            
  DK7="$(pastel lighten 0.26 "$DKB" | pastel   saturate 0.04 | pastel format hex)"                                                            
  DK8="$(pastel lighten 0.32 "$DKB" | pastel   saturate 0.03 | pastel format hex)"                                                            
  DK9="$(pastel lighten 0.38 "$DKB" | pastel   saturate 0.02 | pastel format hex)"                                                            
  # XFG="$(pastel lighten 0.20 "$DKB" | pastel desaturate 0.02 | pastel format hex)"

  C00="$DK2"
  C08="$DK4"
  C07="$DL5"
  XFG="$DL7"
  C15="$DL8"

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

