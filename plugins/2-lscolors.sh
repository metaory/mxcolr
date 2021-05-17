#!/usr/bin/env bash
LS_COLORS_EXPORT_DESTINATION=$HOME/.zprofile

apply_lscolors () {
  ! command -v vivid    &> /dev/null && Info 1 "vivid command not found"    && return 1
  ! command -v envsubst &> /dev/null && Info 1 "envsubst command not found" && return 1

  envsubst < "$MXBASE"/assets/templates/mxc-lscolors.yml > /tmp/mxc/lscolors.yml

  vivid generate /tmp/mxc/lscolors.yml | tee \
    >(cat > "$MXTEMP"/mxc-ls_colors) \
    >(cat > "$MXDIST"/mxc-ls_colors) \
    >({ read -r lscolors; \
      sed -r -i_OLD -e "s/^export LS_COLORS=.+$/export LS_COLORS='$lscolors'/" \
      "$LS_COLORS_EXPORT_DESTINATION"; }) &> /dev/null

  InfoDone
}
