#!/usr/bin/env bash



BS="$(GetPlugName)"
MXC_FZF_TMP=/tmp/mxc/"$BS"
MXC_VIMIUM_EXTENSION_PATH=$XDG_CONFIG_HOME/chromium/Default/Extensions/dbepggeogbaibhgnhhndojpepiihcmeb/1.66_0
MXC_VIMIUM_OUT="${MXC_FZF_OUT:-"$HOME/.profile"}"

! [ -d "$MXC_VIMIUM_EXTENSION_PATH" ] && Info 1 "MXC_VIMIUM_EXTENSION_PATH $MXC_VIMIUM_EXTENSION_PATH not directory" && exit 1

# cp "$O_CHR1" "$M_CHR1"
# cecho file.txt{,.bak}p "$MXC_VIMIUM_OUT" "$M_CHR2"

__prep () {
  local target="${1}"
  sed -r \
    -e "s/--fg:.+$/--fg: ${XFG};/" \
    -e "s/--bg:.+$/--bg: ${XBG};/" \
    -e "s/--border:.+$/--border: ${DK3};/" \
    -e "s/--bg-dark:.+$/--bg-dark: ${DK1};/" \
    -e "s/--bg-darker:.+$/--bg-darker: ${DK0};/" \
    -e "s/--main-fg:.+$/--main-fg: ${DK7};/" \
    -e "s/--fg-dark:.+$/--fg-dark: ${DK6};/" \
    -e "s/--fg-light:.+$/--fg-light: ${DL5};/" \
    -e "s/--amber-fg:.+$/--amber-fg: ${WBG};/" \
    -e "s/--accent-fg:.+$/--accent-fg: ${SBG};/" \
    -e "s/--purple-dark:.+$/--purple-dark: ${EBG};/" \
    "$target" > "/tmp/mxc/${MXC_FZF_TMP}_${target##*/}"

  InfoDone "$1"
}

__prep "$MXC_VIMIUM_EXTENSION_PATH/content_scripts/vimium.css"
__prep "$MXC_VIMIUM_EXTENSION_PATH/pages/vomnibar.css"

InfoDone

apply_vimium () {
  if [[ "$XOPT" == *"nochr"* ]]; then InfoIgnore; return; fi

  cp -v --backup "/tmp/mxc/${MXC_FZF_TMP}_vimium.css"   "$MXC_VIMIUM_EXTENSION_PATH/content_scripts/vimium.css"
  cp -v --backup "/tmp/mxc/${MXC_FZF_TMP}_vomnibar.css" "$MXC_VIMIUM_EXTENSION_PATH/pages/vomnibar.css"        

  InfoDone
}


