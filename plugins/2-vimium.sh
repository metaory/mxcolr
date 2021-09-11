#!/usr/bin/env bash

BS="$(GetPlugName)"
VIMIUM_TMP=/tmp/mxc/"$BS"
VIMIUM_EXTENSION_PATH=$HOME/.config/chromium/Default/Extensions/dbepggeogbaibhgnhhndojpepiihcmeb/1.67_0; #  XXX replace me with ls !
VIMIUM_TARGETS=("$VIMIUM_EXTENSION_PATH"/{content_scripts/vimium.css,pages/vomnibar.css})

# ! [ -d "$VIMIUM_EXTENSION_PATH" ] && Info 1 "VIMIUM_EXTENSION_PATH $VIMIUM_EXTENSION_PATH not directory" && return

# /* MXC_PLACEHOLDER */
__prep () {
  local target="${1}"
  sed -r \
    -e "s/--mxc-c01:.+$/--mxc-c01: ${C01};/" \
    -e "s/--mxc-c02:.+$/--mxc-c02: ${C02};/" \
    -e "s/--mxc-c03:.+$/--mxc-c03: ${C03};/" \
    -e "s/--mxc-c04:.+$/--mxc-c04: ${C04};/" \
    -e "s/--mxc-c05:.+$/--mxc-c05: ${C05};/" \
    -e "s/--mxc-c06:.+$/--mxc-c06: ${C06};/" \
    -e "s/--mxc-c07:.+$/--mxc-c07: ${C07};/" \
    -e "s/--mxc-c08:.+$/--mxc-c08: ${C08};/" \
    -e "s/--mxc-c09:.+$/--mxc-c09: ${C09};/" \
    -e "s/--mxc-c10:.+$/--mxc-c10: ${C10};/" \
    -e "s/--mxc-c11:.+$/--mxc-c11: ${C11};/" \
    -e "s/--mxc-c12:.+$/--mxc-c12: ${C12};/" \
    -e "s/--mxc-c13:.+$/--mxc-c13: ${C13};/" \
    -e "s/--mxc-c14:.+$/--mxc-c14: ${C14};/" \
    -e "s/--mxc-c15:.+$/--mxc-c15: ${C15};/" \
    -e "s/--mxc-fg:.+$/--mxc-fg: ${XFG};/" \
    -e "s/--mxc-bg:.+$/--mxc-bg: ${XBG};/" \
    -e "s/--mxc-bg:.+$/--mxc-bg: ${XBG};/" \
    -e "s/--mxc-sbg:.+$/--mxc-sbg: ${SBG};/" \
    -e "s/--mxc-wbg:.+$/--mxc-wbg: ${WBG};/" \
    -e "s/--mxc-ebg:.+$/--mxc-ebg: ${EBG};/" \
    -e "s/--mxc-sfg:.+$/--mxc-sfg: ${SFG};/" \
    -e "s/--mxc-wfg:.+$/--mxc-wfg: ${WFG};/" \
    -e "s/--mxc-efg:.+$/--mxc-efg: ${EFG};/" \
    -e "s/--mxc-border:.+$/--mxc-border: ${DK3};/" \
    -e "s/--mxc-bg-dark:.+$/--mxc-bg-dark: ${DK1};/" \
    -e "s/--mxc-bg-darker:.+$/--mxc-bg-darker: ${DK0};/" \
    -e "s/--mxc-main-fg:.+$/--mxc-main-fg: ${DK7};/" \
    -e "s/--mxc-fg-dark:.+$/--mxc-fg-dark: ${DK6};/" \
    -e "s/--mxc-fg-light:.+$/--mxc-fg-light: ${DL5};/" \
    -e "s/--mxc-amber-fg:.+$/--mxc-amber-fg: ${WBG};/" \
    -e "s/--mxc-accent-fg:.+$/--mxc-accent-fg: ${SBG};/" \
    -e "s/--mxc-purple-dark:.+$/--mxc-purple-dark: ${EBG};/" \
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


for t in "${VIMIUM_TARGETS[@]}"
    do __prep "$t"
done

Info "${VIMIUM_TMP}"

