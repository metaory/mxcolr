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
    -g, --generate <strategy> | <vivid, lch> (Pastel randomization strategy) default is vivid 
    -u, --update              | apply to all plugins
    -U, --update-force        | force apply to all plugins without any prompts
    -d, --demo                | basic demo
    -D, --demo-all            | complete demo
    -l, --list                | list all saved snapshots
    -s, --save                | save snapshot
    --verbose                 | verbose logs

### primary output file without any plugins:
#### `$XDG_CONFIG_HOME/mxc/theme.mx `
#### **sample output** [theme.mx](data/sample_theme.mx)

#### intended to be sourced in `.profile` or `bashrc` and have apps that can directly access system env read system scheme from it
### other apps can have a plugin to do the necessarily replace / steps,

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

![screenshot](data/2021-05-13-155549_1920x1080_scrot.png)

![screenshot](data/2021-05-13-172453_1920x1080_scrot.png)

***

Requirements
------------
- [pastel](https://github.com/sharkdp/pastel)

Optional Requirements
---------------------
- [tmux](https://github.com/tmux/tmux)
- [oomox](https://github.com/themix-project/oomox)
- [spicetify-cli](https://github.com/khanhas/spicetify-cli)
- [ffmpeg](https://github.com/FFmpeg/FFmpeg)

Plugins
-------
- Xresources
- Kitty
- ~~Alacritty~~
- Vim colorscheme
- Vim Airline theme
- Vim LeaderF theme
- Vim LeaderGuide theme
- Vimium
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

