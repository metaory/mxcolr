# mxcolr :construction:

<p align="center">
  <img width="193" height="64" src="./assets/screenshots/seed_2021-05-14-123246_193x64_scrot.png">
</p>

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

Motivations
===========
While tools like Oomox and Spicetify are great in reallity you probably got more than GTK theme and Icons you'd want to patch

terminal colors, terminal prompt, window manager / status bar icons, Vim/Atom/SourceCode editor and more 

Some apps might require to compile and build, all of these are just too repetitive and anoying to do for every change, and there is finding color scheme 

This repo goal is easily generate nice random palettes, safely do live preview and patch all configured apps with few keystrokes.

outputs
=======

seed.mx
------
`seed.mx` is a trio of randomely generated colors, it's the core of the palette
- `~/.config/mxc/seed.mx` sample generated [seed.mx](./assets/samples/seed.mx)
> the entire palette is drived from this generated `seed` file 

theme.mx
--------
`theme.mx` is the primary output scheme file
- `~/.config/mxc/theme.mx` sample generated [theme.mx](./assets/samples/theme.mx)
> given the same `seed` file, its <sub>almost!</sub> guaranteed the same `theme.mx` will be produced.

possible variables are:
- gui colors: `C00..C15`, `DK0..DK9`, `DL0..DL9`, `{S{B,F},W{B,F},E{B,F},X{B,F},O{B,F}}G`
- cterm ansi: all gui colors prefixed with `T`
- gui hashless: all gui colors without the `#`. prefixed with `HL`

check sample generated [theme.mx](./assets/samples/theme.mx)

`theme.mx` is intended to be sourced in `.profile` or `bashrc` to have apps that can directly access system env read system scheme from it

<p align="center">
  <img src="./assets/screenshots/samples_2021-05-16-145353_361x247_scrot.png">
</p>

Basic Usage
===========
Templates are the easiest way to produce scheme files for different apps, 
every file in `./templates/{tpl}` will be parsed; scheme variables replaced; and placed in `~/.config/mxc/{tpl}`

### some apps that ONLY rely on template file
- kitty  template:[kitty-theme.conf](./templates/kitty-theme.conf) output:[kitty-theme.conf](./assets/samples/kitty-theme.conf)
- root-mx.css  template:[root-mx.css](./templates/root-mx.css) output:[root-mx.css](./assets/samples/root-mx.css)
- root-mx.less template:[root-mx.less](./templates/root-mx.less) output:[root-mx.less](./assets/samples/root-mx.less)
> (root css/less) are intented to be included in other js / electron apps, like Atom editor or Source Code
- xresources.sh, tmux.sh vim.sh could have too

Advance Usage
=============
if further steps required to patch an app a plugin `sh` file can be added to plugins folder to make the additinal steps

each `sh` file presents in `./plugins` folder is treated as a plugin and is sourced

its expected to follow these patterns:
* filename: `[0-9]-[a-z_].sh` _eg `1-vim.sh`_
  * prefix number is the `order` its loaded, 0 means disabled
  * suffix the `plugin_name`
* plugin file is expected to have a function named `apply_{plugin_name}`
  this function will be called with confirmation prompt

> current active loaded theme variables are available to plugin

> all templates if any are parsed before calling apply_ function

> plugins outputs will first be drafted in `/tmp/mxc` and later upon confirmation prompt moved to `~/.config/mxc/{plugin_name}` 
unless different destination is set


### some apps that rely on BOTH template file AND plugin file
- lscolors template:[lscolors-vivid.yml](./templates/lscolors-vivid.yml) output:[lscolors-vivid.yml](./samples/lscolors-vivid.yml) plugin:[2-lscolors.sh](./plugins/2-lscolors.sh)  output:[lscolors](./samples/lscolors)
- gtk.sh, spotify.sh could have too

### some apps that rely on ONLY plugin file
- vimium, gtk.sh, spotify.sh, awm.sh

***

generate
--------
![generate](./assets/screenshots/generate_210523133127.gif)

update
------
![update](./assets/screenshots/update_210523132539.gif)

snapshot
--------
![snapshot](./assets/screenshots/snapshot_210523132148.gif)
  
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

