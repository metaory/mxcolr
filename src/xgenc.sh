#!/usr/bin/env bash

abs_diff () {
  echo $(($1 >= $2 ? $1 - $2 : $2 - $1))
}
################################
GEN_MIN_DISTANCE=40
ATTMP_WARN_THRESHOLD=5

# shellcheck disable=SC2034
gen_random () {

  local attmp="${1:-1}"
  WBG="$(pastel random -n 1 -s lch_hue | pastel saturate        0.40 | pastel darken   0.10 | pastel format hex)"
  SBG="$(pastel random -n 1 -s vivid   | pastel mix - "$WBG" -f 0.70 | pastel saturate 0.30 | pastel format hex)"
  EBG="$(pastel random -n 1 -s vivid   | pastel mix - "$WBG" -f 0.70 | pastel saturate 0.30 | pastel format hex)"

  local WBG_HUE; WBG_HUE="$(pastel format lch-hue "$WBG")"; WBG_HUE="${WBG_HUE::(-3)}"
  local SBG_HUE; SBG_HUE="$(pastel format lch-hue "$SBG")"; SBG_HUE="${SBG_HUE::(-3)}"
  local EBG_HUE; EBG_HUE="$(pastel format lch-hue "$EBG")"; EBG_HUE="${EBG_HUE::(-3)}"

  local S_distance;S_distance="$(abs_diff "$WBG_HUE" "$SBG_HUE")"
  local E_distance;E_distance="$(abs_diff "$WBG_HUE" "$EBG_HUE")"
  local X_distance;X_distance="$(abs_diff "$SBG_HUE" "$EBG_HUE")"

  Info "ATTP X $attmp"

  Info "ATTMP ${attmp} >> WH:${WBG_HUE} :: [SH:${SBG_HUE} SD:${S_distance}] [EH:${EBG_HUE} ED:${E_distance}]"
  if (( S_distance < GEN_MIN_DISTANCE || E_distance < GEN_MIN_DISTANCE || X_distance < GEN_MIN_DISTANCE )); then
    # pastel format hex "$WBG"; pastel format hex "$SBG"; pastel format hex "$EBG"
    if ! (( attmp % ATTMP_WARN_THRESHOLD )); then PressToContinue "failed $attmp attempts, still continue?"; fi
    gen_random $((++attmp))
  else
    Info "attempt $attmp succeeded, proceeding" 0; return
  fi
}

gen_idiomatic () {
  C01="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - crimson       -f 0.6 | pastel mix - deeppink          -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C02="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - darkseagreen  -f 0.6 | pastel mix - mediumspringgreen -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C03="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - orangered     -f 0.6 | pastel mix - orange            -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C04="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - blue          -f 0.6 | pastel mix - deepskyblue       -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C05="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - indigo        -f 0.6 | pastel mix - slateblue         -f 0.5 | pastel saturate 0.06 | pastel format hex)"
  C06="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.7 | pastel mix - darkturquoise -f 0.6 | pastel mix - deepskyblue       -f 0.5 | pastel saturate 0.06 | pastel format hex)"

  C09="$(pastel lighten   0.10 "$C01" | pastel format hex)"; # REDL
  C10="$(pastel lighten   0.10 "$C02" | pastel format hex)"; # GRNL
  C11="$(pastel lighten   0.10 "$C03" | pastel format hex)"; # YELL
  C12="$(pastel lighten   0.10 "$C04" | pastel format hex)"; # BLUL
  C13="$(pastel lighten   0.10 "$C05" | pastel format hex)"; # PRPL
  C14="$(pastel lighten   0.10 "$C06" | pastel format hex)"; # CYNL

  WBX="$(pastel saturate  0.30 "$WBG" | pastel lighten 0.10  | pastel format hex)" ; # ZXX
  WFX="$(pastel textcolor      "$WBX" | pastel darken  0.20  | pastel format hex)" ; # ZXF

  CX1="$(pastel saturate  0.25 "$C01" | pastel darken  0.02  | pastel format hex)" ; # C01
  CX2="$(pastel saturate  0.25 "$C02" | pastel darken  0.02  | pastel format hex)" ; # C02
  CX3="$(pastel saturate  0.25 "$C03" | pastel darken  0.02  | pastel format hex)" ; # C03  
  CX4="$(pastel saturate  0.25 "$C04" | pastel darken  0.02  | pastel format hex)" ; # C04
  CX5="$(pastel saturate  0.25 "$C05" | pastel darken  0.02  | pastel format hex)" ; # C05
  CX6="$(pastel saturate  0.25 "$C06" | pastel darken  0.02  | pastel format hex)" ; # C06

  WFG="$(pastel textcolor      "$WBG" | pastel darken 0.2           | pastel format hex)"
  EFG="$(pastel textcolor      "$EBG" | pastel darken 0.2   | pastel saturate 0.20 | pastel format hex)"
  SFG="$(pastel textcolor      "$SBG" | pastel darken 0.2   | pastel saturate 0.20 | pastel format hex)"
  Info "Done" 0
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
  DK3="$(pastel darken  0.02 "$DKB" | pastel   saturate 0.08 | pastel format hex)"                                                            
  DK4="$(pastel lighten 0.06 "$DKB" | pastel   saturate 0.06 | pastel format hex)"                                                            
  DK5="$(pastel lighten 0.12 "$DKB" | pastel   saturate 0.04 | pastel format hex)"                                                            
  DK6="$(pastel lighten 0.18 "$DKB" | pastel   saturate 0.02 | pastel format hex)"                                                            
  DK7="$(pastel lighten 0.26 "$DKB" | pastel   saturate 0.02 | pastel format hex)"                                                            
  DK8="$(pastel lighten 0.32 "$DKB" | pastel   saturate 0.02 | pastel format hex)"                                                            
  DK9="$(pastel lighten 0.38 "$DKB" | pastel   saturate 0.02 | pastel format hex)"                                                            
  XFG="$(pastel lighten 0.20 "$DKB" | pastel desaturate 0.02 | pastel format hex)"                                                            

  C00="$DK3"
  C08="$DK4"
  C07="$DL5"
  C15="$DL9"

  Info "Done" 0
}
# ## <<< ##########
# #################
################################
GeneratePalette () { 
  ClearTemp
  gen_random
  gen_idiomatic
  gen_shades
  gen_ansi

  SaveSeed
  SaveTheme
  LoadTempTheme
  Info "Done" 0
}
################################
################################
UpdatePalette () {
  LoadTempSeed
  gen_idiomatic
  gen_shades
  gen_ansi

  SaveTheme
  LoadTempTheme
  Info "Done" 0
}
################################

