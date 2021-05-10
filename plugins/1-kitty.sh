#!/usr/bin/env bash

M_KIT=$MXTEMP/mx-kit.conf
O_KIT=$MXDIST/mx-kit.conf

cat <<  EOF > "$M_KIT"
color0                 $C00
color8                 $C08
color7                 $C07
color15                $C15
color1                 $C01
color9                 $C09
color2                 $C02
color10                $C10
color3                 $C03
color11                $C11
color4                 $C04
color12                $C12
color5                 $C05
color13                $C13
color6                 $C06
color14                $C14

color20                $SBG
color21                $SFG
color30                $WBG
color31                $WFG
color40                $EBG
color41                $EFG

background             $XBG
foreground             $XFG
selection_background   $OBG
selection_foreground   $OFG
cursor_text_color      $WFX
cursor                 $WBX
EOF


InfoSourced

apply_kitty () {
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  cp "$M_KIT" "$O_KIT"
  # kitty @ "$KSOCK" set-colors "$KFLAG" "$MXKIT" 2>/dev/null
  Info '' 0
}
