#!/usr/bin/env bash

SPICETIFY_PATH=$XDG_CONFIG_HOME/spicetify

BS="$(GetPlugName).mx"
MXC_SPOTIFY_TMP=/tmp/mxc/"$BS"
MXC_SPOTIFY_OUT="${MXC_SPOTIFY_OUT:-"$MXDIST/$BS"}"

cat <<  EOF > "$MXC_SPOTIFY_TMP"
[Base]
main_bg                               =${XBG:1}
main_fg                               =${XFG:1}
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

InfoDone "$MXC_SPOTIFY_TMP"

  # TODO remove me 
  # NOT NEEDED
temporary_legacy_spotify_hack () {
  Info "Temporary hack"
  Info 'deprecated' 1; return

  NEW_ZLINK="${DK0}"; NEW_GLUE="${DL0}"
  if [[ -e "$SPICETIFY_PATH"/Themes/Metafy/legacy ]]; then
    . "$SPICETIFY_PATH"/Themes/Metafy/legacy
  else 
    echo "export PRE_ZLINK='#1a1b26'   ; export PRE_GLUE='#1a1b26'"   > "$SPICETIFY_PATH"/Themes/Metafy/legacy
    . "$SPICETIFY_PATH"/Themes/Metafy/legacy
  fi

  echo "export PRE_ZLINK='$NEW_ZLINK'; export PRE_GLUE='$NEW_GLUE'" > "$SPICETIFY_PATH"/Themes/Metafy/legacy
  mlg "PRE_ZLINK ${PRE_ZLINK}"; mlg "PRE_GLUE ${PRE_GLUE}"; mlg "NEW_ZLINK ${NEW_ZLINK}"; mlg "NEW_GLUE ${NEW_GLUE}"

  cp "$SPICETIFY_PATH"/Extracted/Themed/zlink/css/zlink.css         /tmp/mxc_spotify_zlink_"$(date +%s)".css
  cp "$SPICETIFY_PATH"/Extracted/Themed/glue-resources/css/glue.css /tmp/mxc_spotify_glue_"$(date +%s)".css
  cp "$SPICETIFY_PATH"/Themes/Metafy/legacy                         /tmp/mxc_spotify_legacy_"$(date +%s)"

  Info "Legacy backups in /tmp/mxc_spotify_*" 2

  sed -r -i \
    -e "s/${PRE_ZLINK}/${NEW_ZLINK}/g" \
    "$SPICETIFY_PATH"/Extracted/Themed/zlink/css/zlink.css
  #
  sed -r -i \
    -e "s/${PRE_GLUE}/${NEW_GLUE}/g" \
    "$SPICETIFY_PATH"/Extracted/Themed/glue-resources/css/glue.css

  InfoDone
}

  # TODO remove me 
  # NOT NEEDED
patch_all_css () {
  sed -r -i \
    -e "s/$1\,/var\(--modspotify_$2\)\,/g" \
    -e "s/$1\)/var\(--modspotify_$2\)\)/g" \
    -e "s/$1\ /var\(--modspotify_$2\)\ /g" \
    -e "s/$1\;/var\(--modspotify_$2\)\;/g" \
    -e "s/$1\}/var\(--modspotify_$2\)\}/g" \
      "$3"
  Info "$1>$2" 0 "${3}"
}
# TODO remove me 
# NOT NEEDED
patch_legacy_spotify () {
  PressToContinue "PATCHING LEGACY CSS BROKEN BY [oomoxify-cli:$MXBASE/plugins/4-gtk.sh@ApplyGTKSpt] "
  patch_all_css '#110d0f' 'scrollbar_fg_and_selected_row_bg' "$SPICETIFY_PATH"/Extracted/Themed/glue-resources/css/glue.css
  patch_all_css '#12131e' 'sidebar_and_player_bg'            "$SPICETIFY_PATH"/Extracted/Themed/glue-resources/css/glue.css
  patch_all_css '#0d0609' 'sidebar_and_player_bg'            "$SPICETIFY_PATH"/Extracted/Themed/glue-resources/css/glue.css
  patch_all_css '#555d82' 'pressing_fg'                      "$SPICETIFY_PATH"/Extracted/Themed/glue-resources/css/glue.css
  patch_all_css '#a7afd4' 'light_fg'                         "$SPICETIFY_PATH"/Extracted/Themed/glue-resources/css/glue.css
  patch_all_css '#16A085' 'meta_1'                           "$SPICETIFY_PATH"/Extracted/Themed/glue-resources/css/glue.css

  patch_all_css '#110d0f' 'scrollbar_fg_and_selected_row_bg' "$SPICETIFY_PATH"/Extracted/Themed/zlink/css/zlink.css
  patch_all_css '#12131e' 'sidebar_and_player_bg'            "$SPICETIFY_PATH"/Extracted/Themed/zlink/css/zlink.css
  patch_all_css '#0d0609' 'sidebar_and_player_bg'            "$SPICETIFY_PATH"/Extracted/Themed/zlink/css/zlink.css
  patch_all_css '#555d82' 'pressing_fg'                      "$SPICETIFY_PATH"/Extracted/Themed/zlink/css/zlink.css
  patch_all_css '#a7afd4' 'light_fg'                         "$SPICETIFY_PATH"/Extracted/Themed/zlink/css/zlink.css
  patch_all_css '#16A085' 'meta_1'                           "$SPICETIFY_PATH"/Extracted/Themed/zlink/css/zlink.css
}

apply_spotify () {
  if [[ "$XOPT" == *"nospt"* ]]; then InfoIgnore; return; fi

  cp -v "$MXC_SPOTIFY_TMP" "$SPICETIFY_PATH"/Themes/Metafy/color.ini
  echo "==> $SPICETIFY_PATH/Themes/Metafy/color.ini"

  # TODO remove me 
  # NOT NEEDED
  # patch_legacy_spotify
  # temporary_legacy_spotify_hack

  spicetify update
  spicetify apply -n
  InfoDone "$SPICETIFY_PATH/Themes/Metafy/color.ini"
}
