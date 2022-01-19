#!/usr/bin/env bash
BS="$(GetPlugName)"

AWESOME_THEME=${AWESOME_THEME:-$USER}
AWESOME_THEME_PATH=~/.config/awesome/themes/$AWESOME_THEME
WALLPAPER_BASE_PATH=~/pics/wall/BASE.png

################################
notify () { 
  if command -v notify-send &> /dev/null; then
    notify-send "${1}"
  else
    echo -e "\n ==> $* \n"
  fi
}
################################
ApplyWallpaper () {
  ! [ -e $WALLPAPER_BASE_PATH ] && InfoIgnore "Wallpaper BASE.png not found." "$WALLPAPER_BASE_PATH" && return

  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  local stamp
  stamp=$(date +%s)
  stamp=${stamp:(-8)}

  local base="$HOME"/pics/wall/BASE.png
  if ! [ -e "$base" ]; then InfoError "base wallpaper not found"; InfoError "$base"; return; fi
  cp -v "$HOME"/pics/wall/curr.png "$HOME"/pics/wall/hist/"${stamp}".png
  local tintColor;tintColor=$(darkest SBG WBG EBG)
  PromptWallpaperTint "$tintColor"
  pastel paint -b "$EBG"  " ==> running convert -fill $tintColor with -colorize value: [$REPLY]%"

  # convert "$HOME"/pics/wall/BASE.png -fill "${!tintColor}" -tint "$REPLY" "$HOME"/pics/wall/curr.png
  convert "$HOME"/pics/wall/BASE.png -fill "${!tintColor}" -colorize "$REPLY"% "$HOME"/pics/wall/curr.png
  # convert "$HOME"/pics/wall/curr.png -fill "${!tintColor}" -tint "1"% "$HOME"/pics/wall/curr.png
  InfoDone 
}
# ////////////////////////////  
################################
ApplyIcons () {
  ! [ -d $AWESOME_THEME_PATH ] && InfoIgnore "Awesome Theme $AWESOME_THEME not found." "$AWESOME_THEME_PATH" && return

  if [[ "$XOPT" == *"noico"* ]]; then InfoIgnore; return; fi

  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  # shellcheck disable=SC2046
  # TODO
  mapfile -t APP_ICONS <<<$(find "$AWESOME_THEME_PATH"/icons/apps -name "*.png" -type f 2> /dev/null)
  mapfile -t LAYOUT_ICONS <<<$(find "$AWESOME_THEME_PATH"/icons/layout -name "*.png" -type f 2> /dev/null)

  # local tg_tray_icon=/usr/share/pixmaps/telegram.png
  # [ -w "$tg_tray_icon" ] && APP_ICONS+=("$tg_tray_icon")

  Info "${#APP_ICONS[@]} APP_ICONS"
  for ico in "${APP_ICONS[@]}"; do
    convert "$ico" -fill "${WK6}" -colorize 100%  "$ico"
  done
  InfoDone "${#APP_ICONS[@]} APP_ICONS"

  Info "${#LAYOUT_ICONS[@]} LAYOUT_ICONS"
  for ico in "${LAYOUT_ICONS[@]}"; do
    convert "$ico" -fill "${EBG}" -colorize 100%  "$ico"
  done
  InfoDone "${#LAYOUT_ICONS[@]} LAYOUT_ICONS"

  # Info "${#CUSTOM_ICONS[@]} CUSTOM_ICONS"
  # for ico in "${CUSTOM_ICONS[@]}"; do
  #   cp -v "$ico" /tmp/mxc/"${BS}_${ico##*/}"
  #   convert "$ico" -modulate 100,100,200 "$ico"
  # done
  # InfoDone "${#CUSTOM_ICONS[@]} CUSTOM_ICONS"

  declare -A customIcons
  customIcons[/usr/share/pixmaps/steam_tray_mono.png]=''
  customIcons[/usr/share/icons/hicolor/48x48/apps/telegram.png]=''
  
  for x in "${!customIcons[@]}"; do
    icon="${customIcons[$x]}"; path="${x}"
    ! [ -w $path ] && continue
    echo "icon $icon "
    echo "path $path "
    
    GenIcon "$icon" "$WK6" "$path" 128
  done


  InfoDone
}
# ////////////////////////////  
# ////////////////////////////  

RestartAWM () {
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  notify "restarting AWM in 3s ⏲" ; sleep 3

  if command -v awesome-client &> /dev/null; then
    awesome-client 'awesome.restart()' &>/dev/null || true
  fi

    # awesome --replace & disown
  killall steam &>/dev/null
  killall nm-applet &>/dev/null
  killall telegram-desktop &>/dev/null

  sleep 3

  # if command -v steam &> /dev/null; then steam & disown; fi
  if command -v nm-applet &> /dev/null; then nm-applet & disown; fi
  # if command -v telegram-desktop &> /dev/null; then telegram-desktop & disown; fi

  InfoDone
}

apply_awm () {
  ApplyWallpaper
  ApplyIcons
  RestartAWM
}
