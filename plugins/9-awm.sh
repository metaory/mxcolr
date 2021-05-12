#!/usr/bin/env bash

################################
notify () { awesome-client "require('naughty').notify({ bg='$WBG', fg='$WFG',  timeout=3, opacity = 0.8, text='${1}'})" 2>/dev/null; }
################################
ApplyWallpaper () {
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  local stamp; stamp=$(date +%s); stamp="${stamp:(-8)}"
  local base="$HOME"/pics/wall/BASE.png
  if ! [ -e "$base" ]; then Info 1 "base wallpaper not found"; Info 1 "$base"; exit 1; fi
  convert "$HOME"/pics/wall/BASE.png -fill "${WBG}" -tint 100%  "$HOME"/pics/wall/curr.png
  # convert "$HOME"/pics/wall/curr.png -fill "${WBG}" -tint 100%  "$HOME"/pics/wall/curr.png
  cp "$HOME"/pics/wall/curr.png "$HOME"/pics/wall/hist/"${stamp}".png
  InfoDone
}
# ////////////////////////////  
################################
ApplyIcons () {
  if [[ "$XOPT" == *"noico"* ]]; then InfoIgnore; return; fi
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi

  local LAYOUT_ICONS=("$XDG_CONFIG_HOME"/awesome/themes/metaory/icons/layout/*.png)
  info "LAYOUT_ICONS-Count: ${LAYOUT_ICONS[*]}"
  for layoutico in "${LAYOUT_ICONS[@]}"; do
    convert "$layoutico" -fill "${DL6}" -colorize 100%  "$layoutico"
  done
  info "  ━━ updated ${#LAYOUT_ICONS[@]} layout icons"

  zz="$(find  icons/apps/*.png -print)"; for appico in "${zz[@]}"; do echo "====  $appico"; done
  return
  exit
  local APP_ICONS=("$XDG_CONFIG_HOME"/awesome/themes/metaory/icons/apps/*.png)
  info "APP_ICONS-Count: ${APP_ICONS[*]}" 2
  for appico in "${APP_ICONS[@]}"; do
    convert "$appico" -fill "${DL6}" -colorize 100%  "$appico"
  done
  Info "  ━━ updated ${#APP_ICONS[@]} app icons"
  # sudo cp ~mtheme/icons/steam/steam_tray_mono.png /usr/share/pixmaps/steam_tray_mono.png
  # cp /usr/share/pixmaps/steam_tray_mono.png /tmp/mx__steam_tray_mono.png
  convert /usr/share/pixmaps/steam_tray_mono.png -fill "${DL6}" -colorize 100%  /usr/share/pixmaps/steam_tray_mono.png
  InfoDone
}
# ////////////////////////////  
# ////////////////////////////  
RestartAWM () {
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  notify "restarting AWM in 3s ⏲" ; sleep 3
  (awesome-client 'awesome.restart()' &>/dev/null || true)
  # awesome --replace & disown
  killall nm-applet
  nm-applet & disown
  InfoDone
}

apply_awm () {
  if [[ "$XOPT" == *"noawm"* ]]; then InfoIgnore; return; fi
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  ApplyWallpaper
  ApplyIcons
  RestartAWM
  Info "" 0
}
