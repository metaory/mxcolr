#!/usr/bin/env bash

M_XRS=$MXTEMP/mx-xrs.xdefaults
O_XRS=$MXDIST/mx-xrs.xdefaults

cat                     <<   EOF | tr '[:upper:]' '[:lower:]' > "$M_XRS"
*.color0:               $C00
*.color8:               $C08
*.color7:               $C07
*.color15:              $C15
*.color1:               $C01
*.color9:               $C09
*.color2:               $C02
*.color10:              $C10
*.color3:               $C03
*.color11:              $C11
*.color4:               $C04
*.color12:              $C12
*.color5:               $C05
*.color13:              $C13
*.color6:               $C06
*.color14:              $C14

*.CX1:                  $CX1
*.CX2:                  $CX2
*.CX3:                  $CX3
*.CX4:                  $CX4
*.CX5:                  $CX5
*.CX6:                  $CX6

*.WBX:                  $WBX
*.WFX:                  $WFX
*.WBG:                  $WBG
*.WFG:                  $WFG
*.OBG:                  $OBG
*.OFG:                  $OFG
*.SBG:                  $SBG
*.SFG:                  $SFG
*.EBG:                  $EBG
*.EFG:                  $EFG

*.background:           $XBG
*.foreground:           $XFG
*.selection_background: $OBG
*.selection_foreground: $OFG
*.cursor_text_color:    $WFX
*.cursor:               $WBX

*.DL0:                  $DL0
*.DL1:                  $DL1
*.DL2:                  $DL2
*.DL3:                  $DL3
*.DL4:                  $DL4
*.DL5:                  $DL5
*.DL6:                  $DL6
*.DL7:                  $DL7
*.DL8:                  $DL8
*.DL9:                  $DL9

*.DK0:                  $DK0
*.DK1:                  $DK1
*.DK2:                  $DK2
*.DK3:                  $DK3
*.DK4:                  $DK4
*.DK5:                  $DK5
*.DK6:                  $DK6
*.DK7:                  $DK7
*.DK8:                  $DK8
*.DK9:                  $DK9
EOF

InfoDone "$M_XRS"

apply_xresources() {
  if ! grep "mxc" "$HOME"/.Xresources; then 
    Info "${O_XRS} is not included in $HOME/.Xresources"
    Info 'appent include?'; PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
    echo "#include '$XDG_CONFIG_HOMR/mxc/mx-xrs.xdefaults'" >> "$HOME"/.Xresources; InfoDone 'added'
  fi

  cp -v "$M_XRS" "$O_XRS"; InfoDone "$O_XRS coppied"
  xrdb "$HOME/.Xresources"; Info "refreshed xrdb with $HOME/.Xresources"
}
