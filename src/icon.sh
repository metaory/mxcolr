#!/usr/bin/env bash

GenIcon () {
    local char="${1:?missing char}"
    local color="${2:?missing color}"
    local destinathion="${3:?missing destination}"

    echo "char         : ${char}"
    echo "color        : ${color}"
    echo "destinathion : ${destinathion}"

    convert -font Sauce-Code-Pro-Black-Nerd-Font-Complete \
        -background none \
        -pointsize 96 label:" ${char} " \
        /tmp/mxc/z1.png

    # convert /tmp/mxc/z1.png -transparent "white" /tmp/mxc/z2.png

    convert /tmp/mxc/z1.png -fill "$color" -colorize 100 /tmp/mxc/z2.png

    convert /tmp/mxc/z2.png -background none -gravity center -extent 160x160 /tmp/mxc/z3.png

    convert /tmp/mxc/z3.png -resize 128x128\! "$destinathion"

    InfoDone
}

