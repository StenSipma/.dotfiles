# File:   .zshrc
# Author: Sten Sipma (sten.sipma@ziggo.nl)
# Description:
#	File run by Zsh startup. Configures how Zsh looks, behaves etc.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

############################
## Zsh Features / Options ##
############################

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

## Set the keybindings
# Emacs mode
bindkey -e
# Vim mode:
# bindkey -v

# Keep history of `cd` as in with `pushd` and make `cd -<TAB>` work.
DIRSTACKSIZE=16
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

# Ignore lines prefixed with '#'.
setopt interactivecomments

# Ignore duplicate in history.
setopt hist_ignore_dups

# Autocompletion
autoload -Uz compinit
compinit

# Some random options lol
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# Needed for the globbing pattern used
setopt extendedglob

#############
## General ##
#############

## Load general functionality (shared with bash), and other zsh files
# Store these files in: $HOME/.config/dotfiles 
# (or in a different place if you have a different XDF_CONFIG_HOME default)
CFG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles

# Make the directory if it does not exist
mkdir -p $CFG_DIR


# Source everything in this directory, except for files ending with '.bash'
for file in $(ls $CFG_DIR/*~*.bash); do
        # Uncomment to echo which files are sourced
        #echo "Sourcing $file"
        . $file
done

############
## Prompt ##
############
# This function is called before a command
# (see: man zshmisc)
precmd() {
        # Via shell commands (likely slow)
        #git_prompt=$(eval_git_prompt)
        # Custom via Rust:
        git_prompt=$(/home/sten/Documents/Projects/Rust/git-testing/target/release/git-testing)
        prompt=$(myprompt)
}

# Turn on command substitution in the prompt (and parameter expansion and arithmetic expansion).
setopt promptsubst

## Normal prompt for the terminal at the beginning 
#   of each command. It looks like where "[]" is the prompt:
##
#  [username] at [hostname] in [current_dirname] 
#   $ []
# Choose One:
# - Simple prompt without Git integration
#export PS1='%n at %m in %W
# $ '

# - Same prompt but with basic Git integration
export PS1='${prompt}'
# export PS1='%n at %m in %1~ ${git_prompt}
#  $ '

# Sets the prompt for when a command is specified on more
# than one line (e.g. by using \ or not closing a quote etc.)
export PS2=' | '

# Syntax highlighting in the shell
# from the package: zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
