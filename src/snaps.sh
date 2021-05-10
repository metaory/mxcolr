#!/usr/bin/env bash

ListSnapshots () {
  local snapshots=("$MXSNAP"/*)

  total="${#snapshots[@]}"
  for sid in "${!snapshots[@]}"; do
    local snap=${snapshots[$sid]}; mlg "$snap"
    . "$snap"/theme.mx
    local slabel; slabel="$(basename "$snap" | cut -d'_' -f2-3)"
    # Demo_card "$slabel" "$((sid+1))" "$total"
    # prnt "WBG" "$((sid+1))"
    Demo_block "[$((sid+1))] "
    # Demo_full_block "$((sid+1))/$total [$slabel]"
  done
  pastel paint "$XFG" -n "select "
  pastel paint "$XFG" -b -n "(0-$total): "
  read -r choice
  if ! [[ "$choice" =~ ^[0-9]+$ ]]; then 
    pastel paint "$C01" -b "($choice) numbers only "
    sleep 3
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
    if (diff "$OTHEME" "$snap"/theme.mx 1>/dev/null); then
      mlg "snap exists $snap"
      pastel paint "$C01" -b " Already exists "
      pastel paint "$C09" -i "$snap"; Info "         "


      . "$snap"/theme.mx
      Demo_card "${MXNAME}" "$total" "$total"; Demo

      PromptConfirm " Create anyway "; if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then return; fi
    fi
  done
  # LoadProdTheme
  pastel paint "$C04" " no match found. creating new snapshot"
  PressToContinue
  local stamp; stamp=$(date +%s); stamp="${stamp:(-8)}"
  local sname; sname="${stamp}_${ccount}_${MXNAME}"
  local spath="$MXSNAP"/"$sname"
  cp "$MXDIST" "$spath" -r
  Info '' 0
  pastel paint "$C02" -o "$DK0" -b "$spath"
    # local slabel; slabel="$(basename "$snap" | cut -d'_' -f2-3)"
}
