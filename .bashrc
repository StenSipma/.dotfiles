# File:   .bashrc
# Author: Sten Sipma (sten.sipma@ziggo.nl)
# Description:
#	Bashrc (bash run commands) file which is ran at the startup of a new bash
#       instance. Contains all configuration options specific to the shell,
#       like its appearance and behavior.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#############################
## Bash Features / Options ##
#############################

# Enable vi mode for bash (activated by ESC)
#set -o vi

## Bash Tab completion
source /usr/share/bash-completion/bash_completion  # other package
source $HOME/.config/bash-completion/bash_completion  # own commands

complete -c man which # enable completion for these commands
complete -cf sudo

# Needed for the globbing pattern used
shopt -s extglob

#############
## General ##
#############

## Load general functionality (shared with zsh), and other bash files
# Store these files in: $HOME/.config/dotfiles 
# (or in a different place if you have a different XDF_CONFIG_HOME default)
CFG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles

# Make the directory if it does not exist
mkdir -p $CFG_DIR

# Executing all files not containing a dot
for file in $(ls $CFG_DIR/*([^.])) ; do
        # Uncomment to echo which files are sourced
        #echo "Sourcing $file"
        . $file
done

# Execute all files ending with .bash
for file in $(ls $CFG_DIR/*.bash) ; do
        # Uncomment to echo which files are sourced
        #echo "Sourcing $file"
        . $file
done

############
## Prompt ##
############

## Normal prompt for the terminal at the beginning 
#   of each command. It looks like where "[]" is the prompt:
##
#  [username] at [hostname] in [current_dirname] 
#   $ []
##
#export PS1='\u at \h in \W\n $ '
export PS1='\u at \h in \W $(eval_git_prompt)\n $ '

# Sets the prompt for when a command is specified on more
# than one line (e.g. by using \ or not closing a quote etc.)
export PS2=' | '
