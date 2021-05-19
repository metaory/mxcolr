#!/usr/bin/env bash

Playground_2 () {

  gen_random
  gen_idiomatic
  gen_shades
  DemoLive
  PrompRand
  case $REPLY in
    k ) Info 'nope ·';;
    u ) Info 'nope··';;
    n ) Info 'Again ·········'; Playground_2  ;;
    d ) Info 'Full Demo ·····'; DemoAll    ;;
    * ) Info 'Reverting ·····'; Revert     ;;
  esac
}

# ///////////////////////////////////////////

Playground_1 () {
  Info "(XP) XOPT $XOPT"
  local cx=(WBG SBG EBG)


  WBG="$(pastel random -n 1 -s lch_hue   | pastel format hex)"
  SBG="$(pastel random -n 1 -s vivid | pastel mix - "$WBG" -f 0.60 | pastel saturate 0.40 | pastel format hex)"
  EBG="$(pastel complement "$WBG"      | pastel mix - "$WBG" -f 0.60 | pastel saturate 0.40 | pastel format hex)"
  # clear
  echo '    W S E'
  prntlist 'prnt:sp_circle_slant' "${cx[@]}"; pl '-'
  EBG="$(pastel random -n 1 -s lch_hue | pastel mix - "$WBG" -f 0.60 | pastel saturate 0.40 | pastel format hex)"
  fill 1; pl; prntlist 'pl:sp_line_top' "${cx[@]}"; pl '-'
  fill 1; pl "${cx[0]}" " ┗━"; prntlist 'prnt:sp_block_l' "${cx[@]}"; pl "${cx[-1]}" '━┛'; printf 'lch'; pl '-';

  EBG="$(pastel random -n 1 -s vivid | pastel mix - "$WBG" -f 0.60 | pastel saturate 0.40 | pastel format hex)"
  prntlist 'prnt:sp_circle_slant' "${cx[@]}"; printf 'vivid'; pl '-';

  EBG="$(pastel random -n 1 -s lch_hue | pastel mix - "$WBG" -f 0.80 | pastel saturate 0.40 | pastel format hex)"
  prntlist 'prnt:sp_circle_slant' "${cx[@]}"; printf 'lch_XP'; pl '-';
  exit

  local ca=(WBG C01 C02 C03 C04 C05 C06)
  # local cb=(WBG C09 C10 C11 C12 C13 C14)
  # local cx=(WBG RED GRN YEL BLU PRP CYN)

  # fill 4; prntlist 'prnt:sp_cross'        "${cb[@]:1:6}"; pl '-'
  printf 'R G Y B P C'; pl '-'
  printf '1 2 3 4 5 6'; pl '-'
  fill 0; prntlist 'prnt:sp_block_l' "${ca[@]}"; printf 'current'; pl '-'
  gen_random; gen_idiomatic
  fill 2; prntlist 'prnt:sp_block_l' "${ca[@]}"; printf 'new-cur'; pl '-'
  gen_random; gen_idiomatic
  fill 3; prntlist 'prnt:sp_block_l' "${ca[@]}"; printf 'new-cur'; pl '-'
  C01="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.6 | pastel mix - crimson       -f 0.6 | pastel mix - deeppink          -f 0.6 | pastel desaturate 0.10 | pastel format hex)"
  C02="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.6 | pastel mix - darkseagreen  -f 0.6 | pastel mix - mediumspringgreen -f 0.6 | pastel desaturate 0.10 | pastel format hex)"
  C03="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.6 | pastel mix - orangered     -f 0.6 | pastel mix - orange            -f 0.6 | pastel desaturate 0.10 | pastel format hex)"
  C04="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.6 | pastel mix - blue          -f 0.6 | pastel mix - deepskyblue       -f 0.6 | pastel desaturate 0.10 | pastel format hex)"
  C05="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.6 | pastel mix - indigo        -f 0.6 | pastel mix - slateblue         -f 0.6 | pastel desaturate 0.10 | pastel format hex)"
  C06="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.6 | pastel mix - darkturquoise -f 0.6 | pastel mix - deepskyblue       -f 0.6 | pastel desaturate 0.10 | pastel format hex)"
  fill 4; prntlist 'prnt:sp_block_l' "${ca[@]}"; printf 'new-XXX'; pl '-'
  # --------------------------------------------------------------------------------

  local z

  # C01="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.4 | pastel mix - crimson       -f 0.3 | pastel mix - deeppink          -f 0.5 | pastel desaturate 0.10 | pastel format hex)"
  # C02="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.4 | pastel mix - darkseagreen  -f 0.3 | pastel mix - mediumspringgreen -f 0.5 | pastel desaturate 0.10 | pastel format hex)"
  # C03="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.4 | pastel mix - orangered     -f 0.3 | pastel mix - orange            -f 0.5 | pastel desaturate 0.10 | pastel format hex)"
  # C04="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.4 | pastel mix - blue          -f 0.3 | pastel mix - deepskyblue       -f 0.5 | pastel desaturate 0.10 | pastel format hex)"
  # C05="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.4 | pastel mix - indigo        -f 0.3 | pastel mix - slateblue         -f 0.5 | pastel desaturate 0.10 | pastel format hex)"
  # C06="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.4 | pastel mix - darkturquoise -f 0.3 | pastel mix - deepskyblue       -f 0.5 | pastel desaturate 0.10 | pastel format hex)"
  #
  # RED="$(pastel saturate  0.25 "$C01" | pastel darken  0.02  | pastel format hex)" ; # C01
  # GRN="$(pastel saturate  0.25 "$C02" | pastel darken  0.02  | pastel format hex)" ; # C02
  # YEL="$(pastel saturate  0.25 "$C03" | pastel darken  0.02  | pastel format hex)" ; # C03
  # BLU="$(pastel saturate  0.25 "$C04" | pastel darken  0.02  | pastel format hex)" ; # C04
  # PRP="$(pastel saturate  0.25 "$C05" | pastel darken  0.02  | pastel format hex)" ; # C05
  # CYN="$(pastel saturate  0.25 "$C06" | pastel darken  0.02  | pastel format hex)" ; # C06
  #
  #
  # fill 2; prntlist 'prnt:sp_block_l' "${cx[@]}"; printf 'EXP-1 [CX    ] ';
  # fill 5; prntlist 'prnt:sp_dot' "${cx[@]}"; pl '-'
  #
  # fill 3; prntlist 'prnt:sp_block_l' "${ca[@]}"; printf 'EXP-1  [C6   ]  ';
  # prntlist 'prnt:sp_dot_slant' "${ca[@]}"; pl '-'
  #
  # C09="$(pastel lighten   0.10 "$C01" | pastel format hex)"; # REDL
  # C10="$(pastel lighten   0.10 "$C02" | pastel format hex)"; # GRNL
  # C11="$(pastel lighten   0.10 "$C03" | pastel format hex)"; # YELL
  # C12="$(pastel lighten   0.10 "$C04" | pastel format hex)"; # BLUL
  # C13="$(pastel lighten   0.10 "$C05" | pastel format hex)"; # PRPL
  # C14="$(pastel lighten   0.10 "$C06" | pastel format hex)"; # CYNL
 #
  
  # fill 4; prntlist 'prnt:sp_block_l' "${cb[@]}"; printf 'EXP-1 [9 - 14] ';
  # fill 3; prntlist 'prnt:sp_dot' "${cb[@]}"; pl '-'
  #
 #  C01="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - crimson       -f 0.4 | pastel mix - deeppink          -f 0.6 | pastel set hsl-saturation 0.8  | pastel format hex)"
 #  C02="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - darkseagreen  -f 0.4 | pastel mix - mediumspringgreen -f 0.6 | pastel set hsl-saturation 0.8  | pastel format hex)"
 #  C03="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - orangered     -f 0.4 | pastel mix - orange            -f 0.6 | pastel set hsl-saturation 0.8  | pastel format hex)"
 #  C04="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - mediumblue    -f 0.4 | pastel mix - deepskyblue       -f 0.6 | pastel set hsl-saturation 0.8  | pastel format hex)"
 #  C05="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - indigo        -f 0.4 | pastel mix - slateblue         -f 0.6 | pastel set hsl-saturation 0.8  | pastel format hex)"
 #  C06="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - darkturquoise -f 0.4 | pastel mix - deepskyblue       -f 0.6 | pastel set hsl-saturation 0.8  | pastel format hex)"
 # fill 3; prntlist 'prnt:sp_block_l' "${ca[@]}"; printf 'EXP-2'; pl '-'
 #
 #  C01="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - crimson       -f 0.4 | pastel mix - deeppink          -f 0.6 | pastel set chroma +100  | pastel format hex)"
 #  C02="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - darkseagreen  -f 0.4 | pastel mix - mediumspringgreen -f 0.6 | pastel set chroma +100  | pastel format hex)"
 #  C03="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - orangered     -f 0.4 | pastel mix - orange            -f 0.6 | pastel set chroma +100  | pastel format hex)"
 #  C04="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - mediumblue    -f 0.4 | pastel mix - dodgerblue        -f 0.6 | pastel set chroma +100  | pastel format hex)"
 #  C05="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - indigo        -f 0.4 | pastel mix - slateblue         -f 0.6 | pastel set chroma +100  | pastel format hex)"
 #  C06="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - darkturquoise -f 0.4 | pastel mix - deepskyblue       -f 0.6 | pastel set chroma +100  | pastel format hex)"
 # fill 3; prntlist 'prnt:sp_block_l' "${ca[@]}"; printf 'EXP-2'; pl '-'
 #
 #  C01="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - crimson       -f 0.4 | pastel mix - deeppink          -f 0.6 | pastel set lab-a  10 | pastel format hex)"
 #  C02="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - darkseagreen  -f 0.4 | pastel mix - mediumspringgreen -f 0.6 | pastel set lab-a  10 | pastel format hex)"
 #  C03="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - orangered     -f 0.4 | pastel mix - orange            -f 0.6 | pastel set lab-a  10 | pastel format hex)"
 #  C04="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - mediumblue    -f 0.4 | pastel mix - dodgerblue        -f 0.6 | pastel set lab-a  10 | pastel format hex)"
 #  C05="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - indigo        -f 0.4 | pastel mix - slateblue         -f 0.6 | pastel set lab-a  10 | pastel format hex)"
 #  C06="$(pastel mix "$WBG" "$(pastel random -n 1 -s lch_hue)" -f 0.2 | pastel mix - darkturquoise -f 0.4 | pastel mix - deepskyblue       -f 0.6 | pastel set lab-a  10 | pastel format hex)"
 # fill 4; prntlist 'prnt:sp_block_l' "${ca[@]}"; printf 'EXP-3'; pl '-'
  exit
}
# echo "$a" | pastel rotate 20    | pastel format hex
# echo --
# echo "$a" | pastel set red 100  | pastel format hex
# echo "$a" | pastel set red 1000 | pastel saturate 0.1 | pastel darken 0.2  | pastel format hex
# echo --
# echo "$a" | pastel set red 1000 | pastel format hex
# echo "$a" | pastel set red 9000 | pastel format hex


  # local strategy
  # # strategy="${XOPT:-alpha}"
  # if [[ "$XOPT" = beta ]]; then
  #   Info "BETA GeneratePalette XOPT $XOPT"
  #   strategy="lch_hue"
  # else
  #   Info "ALPHA GeneratePalette XOPT $XOPT"
  #   strategy="vivid"
  # fi


  # export REDL ; export GRNL ; export YELL ; export BLUL ; export PRPL ; export CYNL ; export ZXX ; export ZX1 ; export ZXF ; export ZX2
  # export C00="$DK3"
  # export C08="$DK4"
  # export C07="$DK6"
  # export C15="$OFG"
  # export T_BACKGROUND="$XBG"
  # export T_FOREGROUND="$XFG"
  # export T_SELECTION_BACKGROUND="$OBG"
  # export T_SELECTION_FOREGROUND="$OFG"
  ##


  XP_prompt () {
    PromptConfirm "continue with (${FUNCNAME[0]}) "; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
    #
    Info Laterz
    #
    if [[ "$XOPT" == *"nogtk"* ]]; then Info "   ignoring (${FUNCNAME[0]}) ···"; return; fi
    if [[ "$XOPT" == *"nosp"* ]]; then Info "   ignoring (${FUNCNAME[0]}) ···"; return; fi
    Info "(XP) POST ?" 3
    PromptConfirm
    if  [[ "$REPLY" =~ ^[Yy]$ ]]; then
      Info "(XP)    PASS $REPLY" 0
    else
      Info "(XP)    FAIL $REPLY" 1
    fi

    PromptConfirm 'foo bar'
    if  [[ "$REPLY" =~ ^[Yy]$ ]]; then
      Info "(22)    PASS $REPLY" 0
    else
      Info "(22)    FAIL $REPLY" 1
    fi

    zz=$(PromptConfirm)
    Info "Z:: $zz"
  }

