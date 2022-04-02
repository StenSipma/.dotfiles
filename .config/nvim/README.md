# NeoVim

This directory contains my configuration for `[NeoVim](https://neovim.io/)`. It
is a mix of Vimscript and Lua.

The main/initial configuration file is `init.vim`, in which all the plugins are
loaded and some basic settings / keybindings are set. In principle all the
configuration options for individual plugins are set in individual files in the
`./plugin/*.vim` folder. All Lua config files are in the `./lua` directory,
mostly under the `./lua/sten` subdirectory to avoid namespace conflicts with
other plugins.

In general, a plugin is configured in the following way, assuming it can be
started via Lua:
1. It is loaded in `init.vim` using the Vim-Plug plugin manager
2. Custom options are defined in `./lua/sten/conf.lua` in a specific dictionary
   entry named `<plugin_name>_conf`.
3. The plugin is activated in its specific `./plugin/<plugin_name>.vim`, using
   a line like: `lua require"<plugin_name>".setup( require"sten.conf".<plugin_name>_conf )`

## General Plugin List:
- **Completion Menu** `nvim_cmp`
- **LSP** `nvim_lsp`
- **Snippets** `LuaSnip`
- **Plugin Manager** `vim-plug`
- **Theme** `gruvbox-material` (hard)

