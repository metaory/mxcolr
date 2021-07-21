#!/usr/bin/env bash

BS="$(GetPlugName)"
VIMIUM_TMP=/tmp/mxc/"$BS"
VIMIUM_EXTENSION_PATH=$XDG_CONFIG_HOME/chromium/Default/Extensions/dbepggeogbaibhgnhhndojpepiihcmeb/1.67_0; #  XXX replace me with ls !
VIMIUM_TARGETS=("$VIMIUM_EXTENSION_PATH"/{content_scripts/vimium.css,pages/vomnibar.css})

# ! [ -d "$VIMIUM_EXTENSION_PATH" ] && Info 1 "VIMIUM_EXTENSION_PATH $VIMIUM_EXTENSION_PATH not directory" && return

__prep () {
  local target="${1}"
  sed -r \
    -e "s/--fg:.+$/--fg: ${XFG};/" \
    -e "s/--bg:.+$/--bg: ${XBG};/" \
    -e "s/--sbg:.+$/--sbg: ${SBG};/" \
    -e "s/--wbg:.+$/--wbg: ${WBG};/" \
    -e "s/--ebg:.+$/--ebg: ${EBG};/" \
    -e "s/--sfg:.+$/--sfg: ${SFG};/" \
    -e "s/--wfg:.+$/--wfg: ${WFG};/" \
    -e "s/--efg:.+$/--efg: ${EFG};/" \
    -e "s/--border:.+$/--border: ${DK3};/" \
    -e "s/--bg-dark:.+$/--bg-dark: ${DK1};/" \
    -e "s/--bg-darker:.+$/--bg-darker: ${DK0};/" \
    -e "s/--main-fg:.+$/--main-fg: ${DK7};/" \
    -e "s/--fg-dark:.+$/--fg-dark: ${DK6};/" \
    -e "s/--fg-light:.+$/--fg-light: ${DL5};/" \
    -e "s/--amber-fg:.+$/--amber-fg: ${WBG};/" \
    -e "s/--accent-fg:.+$/--accent-fg: ${SBG};/" \
    -e "s/--purple-dark:.+$/--purple-dark: ${EBG};/" \
    "$target" > "${VIMIUM_TMP}_${target##*/}"

  InfoDone "$target"
}

apply_vimium () {
  for t in "${VIMIUM_TARGETS[@]}"; do
    Info "$t"
    cp -v --backup "${VIMIUM_TMP}_${t##*/}" "$t"
  done

  InfoDone "${VIMIUM_TARGETS[@]}"
}

LoremCols
LoremCols
InfoWarn "Broken since vimium@1.67_0" && return

for t in "${VIMIUM_TARGETS[@]}"
    do __prep "$t"
done

Info "${VIMIUM_TMP}"

