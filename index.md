# mxcolr ▲

<p align="center">
  <img width="193" height="64" src="./assets/screenshots/seed_2021-05-14-123246_193x64_scrot.png">
</p>

<p align="center">
  :warning: Warning! This is experimental! :warning:
</p>

Usage
=====
    mxcolr [options] <action> [params]

Options
=======
    --force                 | forcefull update
    --verbose               | verbose logs
    --tmp-only              | exit silently after placing temp files in /tmp/mxc
    --gen-icon              | [char, path]
    --lorem                 | [char, length]
    --lorem-cols            | [char]
    --darkest               | [colors]
    --lightest              | [colors]

Actions
=======
    -i, init                | initial bootstrap
    -g, generate <strategy> | <vivid, lch> (Pastel randomization strategy) default is lch
    -u, update              | apply to all plugins
    -U, update-force        | force apply to all plugins without any prompts
    -d, demo                | basic demo
    -D, demo-all            | complete demo
    -l, list                | list all saved snapshots
    -s, save                | save snapshot
     *                      | intro

Motivations
===========
While tools like Oomox and Spicetify are great in reallity you probably got more than GTK theme and Icons you'd want to patch

Terminal colors, terminal prompt, window manager / status bar theme / icons, Vim/Atom/SourceCode editor and more 

Some apps might require to compile and build, all of these are just too repetitive and anoying to do for every change, then there is the never ending search for the right color scheme  

What about
----------
- [Pywal](https://github.com/dylanaraps/pywal): all about Wallpaper,, great documentation and support though. 
> almost all [pywal-customization](https://github.com/dylanaraps/pywal/wiki/customization) can be easilly added
- [Oomox](https://github.com/themix-project/oomox) plugins: possible,, to mxcolr oomox is yet another plugin for gtk theme and icon
 
 
#### This repo goal is to be a tool for generating and previewing palettes and serve as a framework for patching any application with few keystrokes.

## Not for the faint-hearted
Only tested on Arch Linux, not advised for beginner users.
 
Outputs
=======

seed.mx
------
[seed.mx](./assets/samples/seed.mx) is a trio of randomely generated colors, it's the core of the palette
- `~/.config/mxc/seed.mx` sample generated [seed.mx](./assets/samples/seed.mx)
> the entire palette is drived from this generated `seed` file 

Given the same `seed` file, its guaranteed the same `scheme file` be produced.

Possible variables available in all templates or plugins are:
- gui colors: `C00..C15`, `DK0..DK9`, `DL0..DL9`, `{S{B,F},W{B,F},E{B,F},X{B,F},O{B,F}}G`
- cterm ansi: all gui colors prefixed with `T`
- gui hashless: all gui colors without the `#`. prefixed with `HL`

ENV Specifics
=============

Shell
-----
 [root.mx](./assets/samples/root.mx) is the primary output scheme sh file
- `~/.config/mxc/root.mx` sample generated [root.mx](./assets/samples/root.mx)

> intended to be sourced in `.profile` or `bashrc` and have apps that can directly access system env read system scheme from it

Lua scheme
----------

tpl: [mxc-nvim-colors.lua](./templates/mxc-nvim-colors.lua)
out: [mxc-nvim-colors.lua](./assets/samples/mxc-nvim-colors.lua)

Vim
---

output: [root-mx.vim](./assets/samples/root-mx.vim)
plugin: [2-vim.sh](./plugins/2-vim.sh)

> intented to be sourced in vimrc

css / less
----------
css / less for web/electron apps

**root-mx.css** tpl:[root-mx.css](./templates/root-mx.css) out:[root-mx.css](./assets/samples/root-mx.css)

**root-mx.less** tpl:[root-mx.less](./templates/root-mx.less) out:[root-mx.less](./assets/samples/root-mx.less)

> intented to be included in other js / electron apps, like Atom editor or Source Code

***

<p align="center">
  <img src="./assets/screenshots/2021-09-17-082344_331x303_scrot.png">
</p>

Basic Usage
===========
Templates are the easiest way to produce scheme files for different apps, 
every file in `./templates/{tpl}` will be parsed; scheme variables replaced; and placed in `~/.config/mxc/{tpl}`

### some apps that ONLY rely on template file
- kitty  tpl:[kitty-theme.conf](./templates/kitty-theme.conf) out:[kitty-theme.conf](./assets/samples/kitty-theme.conf)
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
- lscolors tpl:[lscolors-vivid.yml](./templates/lscolors-vivid.yml) out:[lscolors-vivid.yml](./samples/lscolors-vivid.yml) plugin:[2-lscolors.sh](./plugins/2-lscolors.sh)  out:[lscolors](./samples/lscolors)
- gtk.sh, spotify.sh could have too

### some apps that rely on ONLY plugin file
- vimium, gtk.sh, spotify.sh, awm.sh

***

## Chain usage temp-only
`mxcolr --tmp-only update` 
will exit silently after placing temp files in `/tmp/mxc`

### for example:
using this template: [cognito-ui.css](./templates/cognito-ui.css) 
```
mxcolr --tmp-only update
aws cognito-idp set-ui-customization --user-pool-id $COGNITO_POOL_ID --css "$(cat /tmp/mxc/cognito-ui.css)"
```
***

generate
--------
![generate 1.4](./assets/screenshots/gifcast_210915123230_generate.gif)

update
------
![update 1.5](./assets/screenshots/gifcast_210915123404_update.gif)

snapshot
--------
![snapshot](./assets/screenshots/snapshot_210523132148.gif)
  
***
  
![screenshot](./assets/screenshots/2021-09-17-084207_2560x1080_scrot.png)
  
![screenshot](./assets/screenshots/2021-05-10-021854_1920x1080_scrot.png)

![screenshot](./assets/screenshots/2021-05-13-155549_1920x1080_scrot.png)

![screenshot](./assets/screenshots/2021-05-13-172453_1920x1080_scrot.png)

***

Requirements
------------
- [pastel](https://github.com/sharkdp/pastel)
- [GNU bc](https://www.gnu.org/software/bc)
- [jq](https://github.com/stedolan/jq)

Optional Requirements
---------------------
- [tmux](https://github.com/tmux/tmux) Terminal Agnostic Live preview
- [oomox](https://github.com/themix-project/oomox) GTK Theme & Icons
- [bullshit](https://aur.archlinux.org/packages/bullshit) Random Palette Name
- [bullshit](https://aur.archlinux.org/packages/bullshit) [origin](http://man2.aiju.de/1/bullshit) Random Palette Name
- [scrot](https://github.com/dreamer/scrot) Palette Image Screenshot
- [spicetify-cli](https://github.com/khanhas/spicetify-cli) Spotify
- [ffmpeg](https://github.com/FFmpeg/FFmpeg) Wallpaper Tints & Custom Icons
- [vivid](https://github.com/sharkdp/vivid) LS_COLORS

Plugins
-------
- Xresources
- Alacritty
- Kitty
- Vim `colors.vim` Nvim `colors.lua`
- Vimium
- FZF
- Spotify
- Slack
- Ranger
- P10k
- Zathura
- GTK Theme
- GTK Icon Theme
- Wallpaper tint
- Tmux
- AwesomeWM `colors.lua`
- LS_COLORS

***


          ___           __            ___     
         /  /\         |  |\         /  /\    
        /  /::|        |  |:|       /  /::\   
       /  /:|:|        |  |:|      /  /:/\:\  
      /  /:/|:|__      |__|:|__   /  /:/  \:\ 
     /__/:/_|::::\ ____/__/::::\ /__/:/ \  \:\
     \__\/  /~~/:/ \__\::::/~~~~ \  \:\  \__\/
           /  /:/     |~~|:|      \  \:\      
          /  /:/      |  |:|       \  \:\     
         /__/:/       |__|:|        \  \:\    
         \__\/         \__\|         \__\/    
             @ mxc-v1.6

<p align="center">
  <img width="374" height="40" src="./assets/screenshots/footer_2021-05-16-221932_374x40_scrot.png">
</p>

