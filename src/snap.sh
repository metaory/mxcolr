#!/usr/bin/env bash

ListSnapshots () {
  local snapshots=("$MXSNAP"/*)

  total="${#snapshots[@]}"
  local slen;slen="$(MXDots)";slen="${#slen}"
  for sid in "${!snapshots[@]}"; do
    local snap=${snapshots[$sid]}; mlg "$snap"
    . "$snap"/theme.mx
    local slabel; slabel="$(basename "$snap" | cut -d'_' -f2-3)"
    # Demo_card "$slabel" "$((sid+1))" "$total"
    # prnt "WBG" "$((sid+1))"
    # Demo_block "[$((sid+1))] "
    local brk; brk=$(tput cols);brk=$((brk/(slen * 2)))
    ! (( sid % brk )) && echo
    printf ' '
    MXSep
    pastel paint -o "$XBG" -b -n "$XFG" "$(printf '%#2d\n' "$sid")"
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
    cp "$selected"/mx-seed "$M_SEED"

    ReGenerate
    return
  else
    pastel paint "$C01" -b "($choice) out of range "
    sleep 3
    ListSnapshots
    return
  fi
  mlg "FROM LIST::: $FOO" 
}
## #####################
SaveSnapshot () {
  LoadProdTheme
  Demo_card; Demo; Info "[${MXNAME}]  Saving Snapshot"; PressToContinue

  local snapshots=("$MXSNAP"/*)

  mlg ">total pre"
  local total; total=$(find "$MXSNAP"/* -type d 2>/dev/null | wc -l)
  mlg ">total $total"

 local highest; highest=$(find "$MXSNAP"/* -type d 2>/dev/null | cut -d'_' -f2 | sort --numeric-sort -r | head -n 1)

  mlg ">highest $highest"

  local ccount; ccount=$((highest+1))
  for sid in "${!snapshots[@]}"; do
    local snap=${snapshots[$sid]}; mlg "$snap"


    # ssum=$(md5sum "$snap"/* | awk '{print $1}')||true;
    # if [ "$csum" = "$ssum" ]; then
    # if (diff "$OTHEME" "$snap"/theme.mx 1>/dev/null); then
    if (diff "$O_SEED" "$snap"/mx-seed 1>/dev/null); then
      mlg "snap exists $snap"

      . "$snap"/theme.mx
      Demo_card "${MXNAME}" "$total" "$total"; Demo

      pastel paint "$C01" -b " duplicate "
      pastel paint "$C09" -i "$snap"; Info "         "

      PromptConfirm " Create anyway "; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
    fi
  done
  PressToContinue "no match found. creating new snapshot"
  local stamp; stamp=$(date +%s); stamp="${stamp:(-8)}"
  local sname; sname="${stamp}_${ccount}_${MXNAME}"
  local spath="$MXSNAP"/"$sname"
  cp "$MXDIST" "$spath" -r
  InfoDone "$spath"
}
