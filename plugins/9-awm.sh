#!/usr/bin/env bash
BS="$(GetPlugName)"

AWESOME_THEME=${AWESOME_THEME:-$USER}
AWESOME_THEME_PATH="$XDG_CONFIG_HOME"/awesome/themes/"$AWESOME_THEME"

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
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  local stamp; stamp=$(date +%s); stamp="${stamp:(-8)}"
  local base="$HOME"/pics/wall/BASE.png
  if ! [ -e "$base" ]; then InfoError "base wallpaper not found"; InfoError "$base"; return; fi
  cp -v "$HOME"/pics/wall/curr.png "$HOME"/pics/wall/hist/"${stamp}".png
  local tintColor;tintColor=$(lightest SBG WBG EBG)
  PromptWallpaperTint "$tintColor"
  pastel paint -b "$EBG"  " ==> running convert fill $tintColor with tint value: [$REPLY]"

  convert "$HOME"/pics/wall/BASE.png -fill "${!tintColor}" -tint "$REPLY" "$HOME"/pics/wall/curr.png
  InfoDone 
}
# ////////////////////////////  
################################
ApplyIcons () {
  if [[ "$XOPT" == *"noico"* ]]; then InfoIgnore; return; fi
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  # shellcheck disable=SC2046
  mapfile -t APP_ICONS <<<$(find "$AWESOME_THEME_PATH"/icons/apps -name "*.png" -type f)
  mapfile -t LAYOUT_ICONS <<<$(find "$AWESOME_THEME_PATH"/icons/layout -name "*.png" -type f)

  local steam_tray_icon=/usr/share/pixmaps/steam_tray_mono.png
  [ -w "$steam_tray_icon" ] && APP_ICONS+=("$steam_tray_icon")

  # local tg_tray_icon=/usr/share/pixmaps/telegram.png
  # [ -w "$tg_tray_icon" ] && APP_ICONS+=("$tg_tray_icon")

  Info "${#APP_ICONS[@]} APP_ICONS"
  for ico in "${APP_ICONS[@]}"; do
    convert "$ico" -fill "${DL6}" -colorize 100%  "$ico"
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

  GenIcon "" "$DL6" /usr/share/icons/hicolor/48x48/apps/telegram.png
  # convert "/usr/share/pixmaps/steam_tray_mono.png -fill "${DL6}" -colorize 100%  /usr/share/pixmaps/steam_tray_mono.png
  # GenIcon "" "$DL6" /usr/share/icons/hicolor/48x48/apps/telegram.png

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
  nm-applet & disown
  InfoDone
}

apply_awm () {
  ApplyWallpaper
  ApplyIcons
  RestartAWM
}
