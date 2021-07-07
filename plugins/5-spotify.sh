#!/usr/bin/env bash

SPICETIFY_PATH=$XDG_CONFIG_HOME/spicetify
SPICETIFY_THEME=Metafy
MXC_SPOTIFY_TMP=/tmp/mxc/spotify-mx

if ! command -v spicetify &> /dev/null; then echo "spicetify not found."; echo " ==> https://github.com/khanhas/spicetify-cli"; exit 1; fi

! [ -d "$SPICETIFY_PATH/Themes/$SPICETIFY_THEME" ] && mkdir -p "$SPICETIFY_PATH/Themes/$SPICETIFY_THEME"

apply_spotify () {
  ! [ -e "$MXC_SPOTIFY_TMP" ] && InfoError "missing templates" && return 1

  cp -v "$MXC_SPOTIFY_TMP" "$SPICETIFY_PATH"/Themes/$SPICETIFY_THEME/color.ini

  spicetify config current_theme Metafy
  spicetify config color_scheme mxc

  spicetify update
  spicetify apply -n

  InfoDone
}

