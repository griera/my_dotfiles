# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

#######################################
##       ENVIRONMENT VARIABLES       ##
#######################################

export PATH="$PATH:/sbin:/usr/sbin:~/bittorrent_sync:~/.dropbox-dist"

# Set where cd builtin finds the directory. If CDPATH is set, the working
# directory MUST BE the first component in order to assure the proper
# functioning of cd builtin
export CDPATH=.:/media/DADES/My_Folder

# Execute its content (bash function) just before Bash displays the prompt.
# See "PROMPT SETTING" section in ~/.bashrc for more information.
export PROMPT_COMMAND=set_prompt1

# Don't put duplicate lines or lines starting with space in the history.
#export HISTCONTROL=ignoreboth

# Eliminate continuous repeated entries from history.
export HISTCONTROL=ignoredups

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1).
export HISTSIZE=1000
export HISTFILESIZE=2000

# Set timestamp to display in history command, using the following format:
# 'dd-mm-yyyy hh:mm:ss '
export HISTTIMEFORMAT='%d-%m-%Y %T '

# A colon-separated list of patterns used to decide which command lines should
# not be saved on the bash history
HISTIGNORE='c:l'

# Use less or most command as a pager.
export PAGER=less

# Used by fc command in order to open vim text editor instead of emacs without
# -e [text_editor] option.
export FCEDIT=vim

# To edit a file with vim being viewed with the less pager (by pressing v).
export EDITOR=vim

# Colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# When compiling an application in the Linux* environment on the DPDK, the
# following variables must be exported
export RTE_SDK=$HOME/dpdk
export RTE_TARGET=x86_64-native-linuxapp-gcc

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
