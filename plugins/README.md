# mxcolr plugin structure

### each `sh` file presents in `./plugins` folder is treated as a plugin and sourced
### its expected to follow these patterns:
* filename: [0-9]-[a-z].sh
  the prefix number is the order it loads
* a function named `apply_{plugin_name}`
  this function will be called with confirmation prompt

### the current active loaded theme variables are available to plugin
#### **sample output** [theme.mx](data/sample_theme.mx)

*** 

_todo_
- [ ] _add template_

