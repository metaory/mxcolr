#!/usr/bin/env bash

SPICETIFY_PATH=$XDG_CONFIG_HOME/spicetify
MXC_SPOTIFY_TMP=/tmp/mxc/spotify-mx

if ! command -v spicetify &> /dev/null; then echo "spicetify not found."; echo " ==> https://github.com/khanhas/spicetify-cli"; exit 1; fi

! [ -d "$SPICETIFY_PATH/Themes/Metafy" ] && mkdir -p "$SPICETIFY_PATH/Themes/Metafy"

apply_spotify () {
  ! [ -e "$MXC_SPOTIFY_TMP" ] && InfoError "missing templates" && return 1

  cp -v "$MXC_SPOTIFY_TMP" "$SPICETIFY_PATH"/Themes/Metafy/color.ini

  spicetify update
  spicetify apply -n

  InfoDone
}

