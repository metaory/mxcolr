# mxcolr :construction:

<p align="center">
  <img width="193" height="64" src="./assets/screenshots/seed_2021-05-14-123246_193x64_scrot.png">
</p>

***

usage
=====
    mxcolr --init
    mxcolr --generate <strategy>
    mxcolr --demo
    mxcolr --update

flags
=====
    -i, --init                | initial bootstrap
    -g, --generate <strategy> | <vivid, lch> (Pastel randomization strategy) default is lch
    -u, --update              | apply to all plugins
    -U, --update-force        | force apply to all plugins without any prompts
    -d, --demo                | basic demo
    -D, --demo-all            | complete demo
    -l, --list                | list all saved snapshots
    -s, --save                | save snapshot
    --verbose                 | verbose logs

outputs
=======

mxseed
------
`mxseed` is a trio of randomely generated colors, it's the core of the palette
- `~/.config/mxc/mx-seed` sample generated [mx-seed](./assets/samples/mx-seed)
> the entire palette is drived from this generated `seed` file 

theme.mx
--------
`theme.mx` is the primary output scheme file
- `~/.config/mxc/theme.mx` sample generated [theme.mx](./assets/samples/theme.mx)
> given the same `seed` file, its guaranteed the same `theme.mx` will be produced.
> _allowing post generation calibrations._

`theme.mx` is intended to be sourced in `.profile` or `bashrc` to have apps that can directly access system env read system scheme from it

basic usage
-----------
Templates are the easiest way to produce scheme files for different apps, 

every file the `./assets/templates/*` will be parsed, scheme variables replaced and placed in `~/.config/mxc/{file}`

advance usage
-------------
if further steps required to patch an app a plugin `sh` file can be added to plugins forlder to make the additinal steps
plugin apply function will be called after parsing templates if there is any template

> plugins outputs will first be drafted in `/tmp/mxc` and later on confirmations will move to `~/.config/mxc/{plugin_name}`
> unless it have a different destination set

### **Plugins Structure** [plugins-readme](./plugins)

some sample outputs
-------------------
- sample output [directory](./assets/samples)
- sample output [theme.mx](./assets/samples/theme.mx)
- sample output [kitty](./assets/samples/kitty-theme.conf)
- sample output [vim-global](./assets/samples/vim-mx.vim)
- sample output [xresources](./assets/samples/xresources-theme.xdefaults)

***

lch strategy
------------
![lch](./assets/screenshots/lch_210511171753.gif)

vivid strategy
--------------
![vivid](./assets/screenshots/vivid_210511172635.gif)

update
------
![update](./assets/screenshots/update_210511172824.gif)

snapshot list
-------------
![list](./assets/screenshots/list_210511173612.gif)
  
***
  
![screenshot](./assets/screenshots/2021-05-10-021854_1920x1080_scrot.png)

![screenshot](./assets/screenshots/2021-05-13-155549_1920x1080_scrot.png)

![screenshot](./assets/screenshots/2021-05-13-172453_1920x1080_scrot.png)

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
- [vivid](https://github.com/sharkdp/vivid)

Plugins
-------
- Xresources
- Kitty
- Vim colorscheme
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
- LS_COLORS

***

<p align="center">
  <img width="374" height="40" src="./assets/screenshots/footer_2021-05-16-221932_374x40_scrot.png">
</p>
