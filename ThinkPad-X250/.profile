# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

#######################################
##      ENVIRONMENTAL VARIABLES      ##
#######################################

PATH="${PATH}:/sbin:/usr/sbin:~/resilio_sync:~/.dropbox-dist"
PATH="${PATH}:~/repos/my_scripts"
export PATH

# Set where cd builtin finds the directory. If CDPATH is set, the working
# directory MUST BE the first component in order to assure the proper
# functioning of cd builtin
export CDPATH=".:~/repos"

# Execute its content (bash function) just before Bash displays the prompt.
# See "PROMPT SETTING" section in ~/.bashrc for more information.
export PROMPT_COMMAND=set_prompt1

# Removes from history all previous line matching the current line.
export HISTCONTROL=erasedups

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1).
export HISTSIZE=1000
export HISTFILESIZE=2000

# Set timestamp to display in history command, using the following format:
# 'dd-mm-yyyy hh:mm:ss '
export HISTTIMEFORMAT='%d-%m-%Y %T '

# A colon-separated list of patterns used to decide which
# command lines should not be saved on the bash history.
export HISTIGNORE='c:l'

# Use less or most command as a pager.
export PAGER=less

# Used by fc command in order to open vim instead of emacs without
# -e [text_editor] option.
export FCEDIT=vim

# To edit a file with vim being viewed with the less (by pressing v).
export EDITOR=vim

# Colored GCC warnings and errors
#GCC_COLORS="error=01;31:warning=01;35:note=01;36"
#GCC_COLORS="${GCC_COLORS}:caret=01;32:locus=01:quote=01"
#export GCC_COLORS

# When compiling an application in the Linux* environment on the DPDK,
# the following variables must be exported
export RTE_SDK=$HOME/dpdk
export RTE_TARGET=x86_64-ivshmem-linuxapp-gcc

#######################################
##              OTHERS               ##
#######################################

# If running bash and ~/.bashrc exists, include it
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

if [[ -z "$DISPLAY" && $(tty) == /dev/tty1 ]]; then
    startx
fi
