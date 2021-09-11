#!/usr/bin/env bash
LS_COLORS_EXPORT_DESTINATION=$HOME/.zshrc

apply_lscolors () {
  ! command -v vivid    &> /dev/null && Info 1 "vivid command not found"    && return 1
  ! command -v envsubst &> /dev/null && Info 1 "envsubst command not found" && return 1

  # ! [ -e /tmp/mxc/lscolors.yml ] && envsubst < "$MXBASE"/templates/mxc-lscolors.yml > /tmp/mxc/lscolors.yml

  vivid generate /tmp/mxc/lscolors-vivid.yml | tee \
    >(cat > "$MXTEMP"/ls_colors) \
    >(cat > "$MXDIST"/ls_colors) \
    >({ read -r lscolors; \
      sed -r -i_OLD -e "s/^export LS_COLORS=.+$/export LS_COLORS='$lscolors'/" \
      "$LS_COLORS_EXPORT_DESTINATION"; }) &> /dev/null

  InfoDone
}
