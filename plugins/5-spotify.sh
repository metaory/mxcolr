#!/usr/bin/env bash

SPICETIFY_PATH=~/.config/spicetify
SPICETIFY_THEME=Metafy
MXC_SPOTIFY_TMP=/tmp/mxc/spotify-mx
not_found_msg="spicetify not found."
# #main > div > div.Root__top-container > nav { max-width: 100px; }

if ! command -v spicetify &> /dev/null; then
  echo $not_found_msg
  echo " ==> https://github.com/khanhas/spicetify-cli"
  ignore=1 
fi

! [ $ignore ] && ! [ -d "$SPICETIFY_PATH/Themes/$SPICETIFY_THEME" ] && mkdir -p "$SPICETIFY_PATH/Themes/$SPICETIFY_THEME"

apply_spotify () {
  [ $ignore ] && InfoIgnore $not_found_msg && return 1

  ! [ -e "$MXC_SPOTIFY_TMP" ] && InfoError "missing templates" && return 1

  cp -v "$MXC_SPOTIFY_TMP" "$SPICETIFY_PATH"/Themes/$SPICETIFY_THEME/color.ini

  spicetify config current_theme Metafy
  spicetify config color_scheme mxc

  spicetify update
  spicetify apply -n

  InfoDone
}

