#!/usr/bin/env bash


M_CHR1=$MXTEMP/mx-chr1.css
M_CHR2=$MXTEMP/mx-chr2.css

O_CHR1=$XDG_CONFIG_HOME/chromium/Default/Extensions/dbepggeogbaibhgnhhndojpepiihcmeb/1.66_0/content_scripts/vimium.css
O_CHR2=$XDG_CONFIG_HOME/chromium/Default/Extensions/dbepggeogbaibhgnhhndojpepiihcmeb/1.66_0/pages/vomnibar.css

cp "$O_CHR1" "$M_CHR1"
cp "$O_CHR2" "$M_CHR2"

__update () {
  local target="${1}"
  sed -r -i \
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
    "$target"

  Info "Done" 0
}

__update "$M_CHR1"
__update "$M_CHR2"

InfoSourced

ApplyChrVimium () {
  if [[ "$XOPT" == *"nochr"* ]]; then InfoIgnore; return; fi
  PromptContinue; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi

  cp "$M_CHR1" "$O_CHR1"
  cp "$M_CHR2" "$O_CHR2"
  Info "Done" 0
}

