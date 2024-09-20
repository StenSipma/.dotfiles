# Neovim Config
Assumes you are running the nightly version of Neovim.

## Package Manger
[packer.nvim](https://github.com/wbthomason/packer.nvim), installed via AUR package
[nvim-packer-git](https://aur.archlinux.org/packages/nvim-packer-git).

## First time setup
Open the packer file with Neovim `nvim lua/sten/packer.lua`, source it (`:so %`) and
run `:PackerSync` (maybe do this twice if something fails). Then restart and it will
install treesitter parsers and lsp servers. When luassert asks something,
select the first option (1).
