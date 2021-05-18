# mxcolr plugin structure

<p align="center">
  <img width="193" height="64" src="../assets/screenshots/seed_2021-05-14-123246_193x64_scrot.png">
</p>


### each `sh` file presents in `./plugins` folder is treated as a plugin and is sourced
### its expected to follow these patterns:
* filename: `[0-9]-[a-z_].sh` _`1-vim.sh`_
  * prefix number is the `order` its loaded, 0 means disabled
  _(for plugins that depends on other plugins)_
  * suffix the `plugin_name`
* plugin file is expected to have a function named `apply_{plugin_name}`
  this function will be called with confirmation prompt

### current active loaded theme variables are available to plugin
> plugins outputs will first be drafted in `/tmp/mxc` and later upon confirmation prompt moved to `~/.config/mxc/{plugin_name}`
> unless it have a different destination set

- sample output [directory](../assets/samples)
- sample output [theme.mx](../assets/samples/theme.mx)
- sample output [kitty](../assets/samples/kitty-theme.conf)
- sample output [vim-global](../assets/samples/vim-mx.vim)
- sample output [xresources](../assets/samples/xresources-theme.xdefaults)

<p align="center">
  <img src="../assets/screenshots/samples_2021-05-16-145353_361x247_scrot.png">
</p>

*** 

_todo_
- [X] add template [template_directory](../assets/templates)

***

Related Projects
----------------
- [X] [fzf-chromium-history](https://github.com/metaory/fzf-chromium-history) (mfz-web)
- [ ] meta-tmux
- [ ] meta-vim
- [ ] meta-vimium
- [ ] meta-chromium
- [ ] meta-slack
- [ ] meta-spotify
- [ ] meta-awm
