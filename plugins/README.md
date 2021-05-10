# mxcolr plugin structure

### each `sh` file presents in `./plugins` folder is treated as a plugin and is sourced
### its expected to follow these patterns:
* filename: `[0-9]-[a-z].sh`
  * prefix number is the `order` its loaded 
  _(for plugins that depends on other plugins)_
  * suffix the `plugin_name`
* plugin file is expected to have a function named `apply_{plugin_name}`
  this function will be called with confirmation prompt

### current active loaded theme variables are available to plugin
#### **sample variable** [theme.mx](../data/sample_theme.mx)

*** 

_todo_
- [ ] _add template_

