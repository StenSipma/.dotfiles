# Introduction
This repository contains some of my main configuration files / dotfiles. The
handlig is based on the following blog post about [managing dotfiles with a git bare repository](https://www.atlassian.com/git/tutorials/dotfiles)


## Overview
Here is an overview of the most notable configurations in this repository (the applications + file locations):
- [NeoVim](https://neovim.io/) - Highly extensible text editor. Config files [.config/nvim/](./.config/nvim)
- [XMonad](https://xmonad.org/) - Tiling window manager written (& configurable) in [Haskell](https://www.haskell.org/). Files in [.xmonad/](./.xmonad)
- [xmobar](https://xmobar.org/) - Status bar used in combination with *XMonad*. Files in [.config/xmobar/](./.config/xmobar)
- [st](https://st.suckless.org/) - Simple Terminal, suckless software, so there is a [separate repository](https://github.com/StenSipma/st) dedicated to my version of st.
- [Rofi](https://github.com/davatorium/rofi) - Application Launch (much more than that, but that is my main use). Files in [.config/rofi](./.config/rofi)
- Shell configuration files are the [.profile](./.profile) (run at login), and the [.bashrc](./.bashrc) (run at bash startup (i.e. terminal start))
- Some other configuration options shared for X applications are found in [.Xresources](./.Xresources)

## Installation
Because the repository is managed as a bare repository, it is convenient to use
an alias to manage all the files. Here, we use `dgit` as the alias and the folder `$HOME/.dotfiles` in which the bare repository resides.
````bash
alias dgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
````

Check for conflicting files with:
````bash
dgit checkout
````

And back them up in a new directory. Potentially, you need to create sub-directories:
````bash
mkdir .dotfiles-backup
dgit checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
````

Only show tracked files:
````bash
dgit config --local status.showUntrackedFiles no
````

### NeoVim
- Install Plug.Vim (see init.vim)
````
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
````
And then, open neovim and run `:PlugInstall`

- Make a python virtual environment for neovim:
````bash
mkdir -p $XDG_CONFIG_HOME/pyvirtualenvs
python3 -m venv $XDG_CONFIG_HOME/pyvirtualenvs/neovim
source $XDG_CONFIG_HOME/pyvirtualenvs/neovim/bin/activate
pip install pynvim
deactivate
````

### Shell
- Set the shell to Zsh
````
# list available shells
chsh -l
# select the Zsh one (the following is likely good)
chsh -s /bin/zsh
````

- Install Zsh plugins (highlighting)

- Install the prompt with:
````
git clone git@github.com:StenSipma/myprompt.git
cd myprompt
cargo install --path .
cd ..
rm -r myprompt
````

### Git
- Let git know who you are
````bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
````

### Fonts
- FiraCode & Hasklig
````
paru -S otf-hasklig nerd-fonts-fira-code
````

### XMonad



## TODO
- Remove the git-testing dependency in .zshrc

## Dependencies
(and a LOT more!!)
- neovim-nightly
- xmonad xmonad-contrib
- xmobar rofi
- kitty
- exa ripgrep fd bat
