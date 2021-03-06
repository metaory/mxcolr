#!/usr/bin/env bash

BS="$(GetPlugName)-theme.mx"
MXC_GTK_TMP=/tmp/mxc/"$BS"
MXC_GTK_OUT="${MXC_GTK_OUT:-"$MXDIST/$BS"}"


:>"$MXC_GTK_TMP"

cat <<  EOF > "$MXC_GTK_TMP"
$(get_header)

NOGUI=True
NAME=${MXC_V}

GTK3_GENERATE_DARK=True
BASE16_GENERATE_DARK=True

BASE16_INVERT_TERMINAL=False
BASE16_MILD_TERMINAL=False

CINNAMON_OPACITY=1.0
CARET1_FG=${WBX:1}
CARET2_FG=${SBG:1}
ACCENT_BG=${EBG:1}
CARET_SIZE=0.04
GRADIENT=0.0

OUTLINE_WIDTH=1
BTN_OUTLINE_OFFSET=-3
BTN_OUTLINE_WIDTH=1

BG=${XBG:1}
BTN_BG=${C00:1}
BTN_FG=${C07:1}
FG=${XFG:1}
HDR_BTN_BG=${C00:1}
HDR_BTN_FG=${C07:1}
ICONS_NUMIX_STYLE=0
ICONS_SYMBOLIC_ACTION=${C00:1}
ICONS_SYMBOLIC_PANEL=${C08:1}
ICONS_STYLE=archdroid
ICONS_ARCHDROID=${WK6:1}
ICONS_DARK=${SK0:1}
ICONS_LIGHT=${SK4:1}
ICONS_LIGHT_FOLDER=${SK2:1}
ICONS_MEDIUM=${C05:1}
HDR_BG=${SK0:1}
HDR_FG=${SK6:1}
SEL_BG=${OBG:1}
SEL_FG=${OFG:1}
TXT_BG=${XBG:1}
TXT_FG=${XFG:1}
MENU_BG=${SK1:1}
MENU_FG=${SK7:1}
SPACING=3
ROUNDNESS=2

SPOTIFY_PROTO_BG=${XBG:1}
SPOTIFY_PROTO_FG=${SK2:1}
SPOTIFY_PROTO_SEL=${WBG:1}

THEME_STYLE=oomox
TERMINAL_THEME_MODE=manual
TERMINAL_THEME_AUTO_BGFG=False
TERMINAL_THEME_EXTEND_PALETTE=False
TERMINAL_THEME_ACCURACY=128

TERMINAL_BACKGROUND=${XBG:1}
TERMINAL_FOREGROUND=${XFG:1}
TERMINAL_ACCENT_COLOR=${WBG:1}

TERMINAL_COLOR0=${C00:1}
TERMINAL_COLOR1=${C01:1}
TERMINAL_COLOR2=${C02:1}
TERMINAL_COLOR3=${C03:1}
TERMINAL_COLOR4=${C04:1}
TERMINAL_COLOR5=${C05:1}
TERMINAL_COLOR6=${C06:1}
TERMINAL_COLOR7=${C07:1}
TERMINAL_COLOR8=${C08:1}
TERMINAL_COLOR9=${C09:1}
TERMINAL_COLOR10=${C10:1}
TERMINAL_COLOR11=${C11:1}
TERMINAL_COLOR12=${C12:1}
TERMINAL_COLOR13=${C13:1}
TERMINAL_COLOR14=${C14:1}
TERMINAL_COLOR15=${C15:1}
EOF

# since https://github.com/metaory/mxcolr/commit/f6d25e
# most of this file couple be replaced by a simple template file

Info "$MXC_GTK_TMP"

ApplyGTKTheme () {
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi

  notify "╸頋━  ━  ${MXC_V} in 3s ⏲" ; sleep 1
  oomox-cli --make-opts all -o "$MXC_V" -t "$HOME"/.themes -m all "$MXC_GTK_OUT"

  # useless 
  [[ -n "$OOMOX_GUI_PREVIEW_ENABLED" ]] && cp -v "$MXC_GTK_TMP" /opt/oomox/plugins/import_random/colors/random3 
}
# ............................ #
ApplyGTKIcon () {
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi

  notify "  ${MXNAME}.${MXC_V} in 3s ⏲" ; sleep 1
  /opt/oomox/plugins/icons_archdroid/archdroid-icon-theme/change_color.sh -o "$MXC_V"  "$MXC_GTK_OUT"

  InfoDone
}
ApplyGTKCursor () {
  CURSOR_THEME=MetaPurpleDark
  # PromptContinue "update cursor theme to ${CURSOR_THEME} ?"
  # if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
  # sed -r -i \
  #   -e "/^gtk-cursor-theme-name/s/=.+$/=${CURSOR_THEME}/" \
  #   ~/.config/gtk-3.0/settings.ini

  InfoDone
}
# ............................ #

apply_gtk () {
  if [[ "$XOPT" == *"nogtk"* ]]; then InfoIgnore; return; fi
  cp -v --backup "$MXC_GTK_TMP" "$MXC_GTK_OUT"
  ApplyGTKTheme
  ApplyGTKIcon
  ApplyGTKCursor
  InfoDone
  # ApplyGTKSpt
}

# ApplyGTKSpt () {
#   if [[ "$XOPT" == *"noxsp"* ]]; then InfoIgnore; return; fi
#   PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
#   oomoxify-cli -s /opt/spotify/Apps "$MXC_GTK_TMP"
#   InfoDone
# }
