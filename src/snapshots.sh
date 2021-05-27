#!/usr/bin/env bash

ListSnapshots () {
  local snapshots=("$MXSNAP"/*)

  total="${#snapshots[@]}"
  local slen;slen="$(MXDots)";slen="${#slen}"
  for sid in "${!snapshots[@]}"; do
    local snap=${snapshots[$sid]}; mlg "$snap"

    [ -e "$snap"/mx-seed ]  && mv "$snap"/mx-seed  "$snap"/seed.mx; # legacy name
    [ -e "$snap"/theme.mx ] && mv "$snap"/theme.mx "$snap"/root.mx; # legacy name

    . "$snap"/root.mx
    local slabel; slabel="$(basename "$snap" | cut -d'_' -f2-3)"
    local brk; brk=$(tput cols);brk=$((brk/(slen * 2)))
    ! (( sid % brk )) && echo
    printf ' '
    MXSep
    (diff "$O_SEED" "$snap"/seed.mx &>/dev/null  && ( Demo_mxname "$sid" )) \
      || pastel paint -o "$XBG" -b -n "$XFG" "$(printf '%#2d\n' "$sid")"
    MXDots
    MXSep

    # Demo_full_block "$((sid+1))/$total [$slabel]"
  done
  echo;echo; pastel paint "$XFG" -n "select "; pastel paint "$XFG" -b -n "(0-$((total-1))): "
  read -r choice
  if ! [[ "$choice" =~ ^[0-9]+$ ]]; then 
    pastel paint "$C01" -b "($choice) numbers only "
    ListSnapshots
    return
  fi

  local selected="${snapshots["$((choice-1))"]}"
  if [ -n "$selected" ]; then
    mlg "selected $selected"
    mlg "choice $choice"
    pastel paint "$XFG" -b "selectd ${selected}"
    Info Broken; PressToContinue
    # exit 1
    ClearTemp
    # TODO copy whole dir
    cp "$selected"/seed.mx "$M_SEED"

    ReGenerate
    return
  else
    pastel paint "$C01" -b "($choice) out of range "
    sleep 3
    ListSnapshots
    return
  fi
}
## #####################
SaveSnapshot () {
  LoadLiveTheme
  Demo_card
  fillCols
  Demo
  Info "[${MXNAME}]  Saving Snapshot"

  local snapshots=("$MXSNAP"/*)

  mlg ">total pre"
  local total; total=$(find "$MXSNAP"/* -type d 2>/dev/null | wc -l)
  mlg ">total $total"

 local highest; highest=$(find "$MXSNAP"/* -type d 2>/dev/null | cut -d'_' -f2 | sort --numeric-sort -r | head -n 1)

  mlg ">highest $highest"

  local ccount; ccount=$((highest+1))
  for sid in "${!snapshots[@]}"; do
    local snap=${snapshots[$sid]}; mlg "$snap"

    [ -e "$snap"/mx-seed ]  && mv "$snap"/mx-seed  "$snap"/seed.mx; # legacy name
    [ -e "$snap"/theme.mx ] && mv "$snap"/theme.mx "$snap"/root.mx; # legacy name

    if (diff "$O_SEED" "$snap"/seed.mx &>/dev/null); then
      mlg "snap exists $snap"
      . "$snap"/root.mx
      InfoError " duplicate 🢃🢃🢃"; InfoWarn "$snap"
      PromptConfirm " Create anyway "; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
    fi
  done
  local stamp; stamp=$(date +%s); stamp="${stamp:(-8)}"
  local sname; sname="${stamp}_${ccount}_${MXNAME}"
  local spath="$MXSNAP"/"$sname"
  # pastel paint -n -b -o "$SBG" "$SFG" " $ccount "; pastel paint -n -b -o "$WBG" "$WFG" " $MXNAME "
  Demo_mxname $ccount; echo
  PressToContinue "creating new snapshot"
  cp "$MXDIST" "$spath" -r
  InfoDone "$spath"
}
