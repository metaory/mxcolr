# mxcolr

## :construction: NOT READY FOR PUBLIC USE :construction:

usage
=====
    mxcolr --init
    mxcolr --generate <strategy>
    mxcolr --demo
    mxcolr --update

flags
=====
    -i, --init                | initial bootstrap
    -g, --generate <strategy> | vivid, lch (Pastel randomization strategy) default is vivid 
    -u, --update              | apply to all plugins
    -U, --update-force        | force apply to all plugins without any prompts
    -d, --demo                | basic demo
    -D, --demo-all            | complete demo
    -l, --list                | list all saved snapshots
    -s, --save                | save snapshot

### primary output file: `$XDG_CONFIG_HOME/mxc/theme.mx `
### **sample output** [theme.mx](data/sample_theme.mx)

### **Plugins Structure** [plugins-readme](plugins)

***

lch strategy
------------
![lch](data/lch_210511171753.gif)
vivid strategy
--------------
![vivid](data/vivid_210511172635.gif)
update
------
![update](data/update_210511172824.gif)
snapshot list
-------------
![list](data/list_210511173612.gif)
  
***
  
![screenshot](data/2021-05-10-021854_1920x1080_scrot.png)

***

Requirements
------------
- [pastel](https://github.com/sharkdp/pastel)

Optional Requirements
---------------------
- [oomox](https://github.com/themix-project/oomox)
- [spicetify-cli](https://github.com/khanhas/spicetify-cli)
- [ffmpeg](https://github.com/FFmpeg/FFmpeg)

Plugins
-------
- Xresource scheme
- Kitty terminal
- ~~Alacritty terminal~~
- Vim colorscheme
- Vim Airline theme
- Vim LeaderF theme
- Vim LeaderGuide theme
- Vimium (chromium extension)
- FZF
- Spotify
- Slack
- Ranger
- P10k
- GTK Theme
- GTK Icon Theme
- Wallpaper tint
- Tmux
- AwesomeWM

