#!/usr/bin/env bash

M_SPOT=$MXTEMP/mx-spt.mx
O_SPOT=$MXDIST/mx-spt.mx
Z_SPOT=$XDG_CONFIG_HOME/spicetify/Themes/Metafy/color.ini


Z_SPT1="$XDG_CONFIG_HOME"/spicetify/Extracted/Themed/zlink/css/zlink.css
Z_SPT2="$XDG_CONFIG_HOME"/spicetify/Extracted/Themed/glue-resources/css/glue.css


cp "$Z_SPOT" "$M_SPOT"

cat <<  EOF > "$M_SPOT"
[Base]
main_bg                               =${XBG:1}
main_fg                               =${XFG:1}
dark_fg                               =${DK3:1}
light_fg                              =${DK7:1}
meta_1                                =${WBG:1}
meta_2                                =${SBG:1}
meta_3                                =${EBG:1}
miscellaneous_hover_bg                =${EBG:1}
preserve_1                            =${EBG:1}
selected_button                       =${DK4:1}
slider_bg                             =${DK4:1}
miscellaneous_bg                      =${DK4:1}
secondary_fg                          =${DK5:1}
indicator_fg_and_button_bg            =${SBG:1}
pressing_fg                           =${SBG:1}
cover_overlay_and_shadow              =${XBG:1}
sidebar_indicator_and_hover_button_bg =${DK1:1}
sidebar_and_player_bg                 =${DK0:1}
scrollbar_fg_and_selected_row_bg      =${DK0:1}
pressing_button_fg                    =${DK0:1}
hover_selected                        =${DK2:1}
pressing_button_bg                    =${WBG:1}
meta_red                              =${C01:1}
meta_yellow                           =${C03:1}
meta_high                             =${C11:1}
meta_amber                            =${EBG:1}
EOF

InfoSourced

ApplySpt () {
  if [[ "$XOPT" == *"nospt"* ]]; then InfoIgnore; return; fi
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi

  cp "$M_SPOT" "$O_SPOT"
  cp "$M_SPOT" "$Z_SPOT"

  local legacy='#1a1b26'
  sed -r -i \
    -e "s/${legacy}/${DL0}/g" \
    "$Z_SPT1"

  sed -r -i \
    -e "s/${legacy}/${XBG}/g" \
    "$Z_SPT2"

  spicetify update
  spicetify apply -n
  Info "Done" 0
}

