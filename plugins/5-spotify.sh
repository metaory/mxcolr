#!/usr/bin/env bash

SPICETIFY_PATH=$XDG_CONFIG_HOME/spicetify

BS="$(GetPlugName).mx"
MXC_SPOTIFY_TMP=/tmp/mxc/"$BS"
MXC_SPOTIFY_OUT="${MXC_SPOTIFY_OUT:-"$MXDIST/$BS"}"

# can move to ./templates 🢃 🢃 🢃 
cat <<  EOF > "$MXC_SPOTIFY_TMP"
[Base]
main_bg                               =${DK0:1}
main_fg                               =${C07:1}
dark_fg                               =${C08:1}
light_fg                              =${C07:1}
meta_1                                =${WBG:1}
meta_2                                =${SBG:1}
meta_3                                =${EBG:1}
miscellaneous_hover_bg                =${EBG:1}
preserve_1                            =${EBG:1}
selected_button                       =${DK4:1}
slider_bg                             =${DK4:1}
miscellaneous_bg                      =${DK4:1}
secondary_fg                          =${C08:1}
indicator_fg_and_button_bg            =${SBG:1}
pressing_fg                           =${DL4:1}
cover_overlay_and_shadow              =${XBG:1}
sidebar_indicator_and_hover_button_bg =${DK1:1}
sidebar_and_player_bg                 =${DK0:1}
scrollbar_fg_and_selected_row_bg      =${DL0:1}
pressing_button_fg                    =${DK0:1}
hover_selected                        =${DK2:1}
pressing_button_bg                    =${SBG:1}
meta_red                              =${C01:1}
meta_yellow                           =${C03:1}
meta_high                             =${C11:1}
meta_amber                            =${EBG:1}
EOF

  # shellcheck disable=SC2016
PopulateFileWith "$MXC_SPOTIFY_TMP" 'APPEND' \
  '${c,,} = ${!hl}' \
  C{00..15}

Info "$MXC_SPOTIFY_TMP"

apply_spotify () {
  cp -v "$MXC_SPOTIFY_TMP" "$SPICETIFY_PATH"/Themes/Metafy/color.ini
  echo "==> $SPICETIFY_PATH/Themes/Metafy/color.ini"

  spicetify update
  spicetify apply -n
  InfoDone "$SPICETIFY_PATH/Themes/Metafy/color.ini"
}

