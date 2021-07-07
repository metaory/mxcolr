#!/usr/bin/env bash

apply_zathura () {
  ! command -v zathura &> /dev/null && return 1

  cp -v --backup /tmp/mxc/zathurarc ~/.config/zathura/zathurarc

  InfoDone
}

