# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=500
HISTFILESIZE=1000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# End of default ~/.bashrc file

##==========================================================================##
##                           ADDITIONS BY GRIERA                            ##
##==========================================================================##

#######################################
##       ENVIRONMENT VARIABLES       ##
#######################################

# Environment variables used to work with CUDA
export CUDA_HOME=/usr/local/cuda-5.0
export LD_LIBRARY_PATH=${CUDA_HOME}/lib

# Environment variables used to work with Android
export ANDROID_HOME=/opt/android-studio
export ANDROID_SDK=/opt/android-studio/sdk

# Environment variable used by fc command in order to open vim
# text editor instead of emacs without -e [text_editor] option
export FCEDIT=/usr/bin/vim

# Environment variable that executes its content just before Bash displays
# the prompt. Change it by choose one of setting prompts functions
# implemented in "PROMPT SETTING" section
export PROMPT_COMMAND=setprompt1

# Environment variable that set where cd builtin finds the directory.
# If CDPATH is set, the working directory SHOULD be the first component
# in order to assure the proper default functioning of cd builtin
export CDPATH=.:~/my_links

# Set up PATH variable
export PATH=${PATH}:${ANDROID_SDK}/platform-tools:${ANDROID_SDK}/tools:\
${ANDROID_HOME}/bin:${CUDA_HOME}/bin:~/my_scripts

# Set timestamp to display in history command, using the following format:
# 'dd-mm-yyyy hh:mm:ss '
export HISTTIMEFORMAT='%d-%m-%Y %T '

# Erase continuous repeated entries from history
HISTCONTROL=ignoredups


#######################################
##           USER VARIABLES          ##
#######################################

export MY_FOLDER="/media/DADES/My_Folder"
export DROPBOX_DIR="${MY_FOLDER}/Dropbox"


#######################################
##           SHELL OPTIONS           ##
#######################################

# Correct minor errors in the spelling of a directory component in a cd builtin
shopt -s cdspell



#######################################
##           PROMPT SETTING          ##
#######################################

# Set variables which contains color codes definitions
# See it for more information about their names.
source ~/.bash_color_codes

# Current selected prompt. It's a two line prompt like this:
#
# ┌─(user@hostname)──[/working_directory]────────[ hh:mm:ss ]
# └─(hist_num_command num_command exit_status_last_command) $
#
# [ hh:mm:ss ] is aligned at top right of terminal.
#
# Second line change the color to red if exit status of last executed command
# differs from 0, otherwise the color is set to green.
#
# '$' for mortal users; '#' for root user (UID = 0)
#
function setprompt1 () {

    local EXIT_STATUS="$?"

    # Set the title bar on terminals which allows it
    case $TERM in
        xterm*|rxvt*)
            TITLEBAR="\[\033]0;\u@\h:\w\007\]"
            ;;
        *)
            TITLEBAR=''
            ;;
    esac

    # Set color related to exit status of last executed command
    local STATUS_COLOR=$FG_GREEN
    if [ $EXIT_STATUS != 0 ]
    then
        local STATUS_COLOR=$FG_RED
    fi

    # Process to align date on top-right corner using terminal width.
    # On prefix_aligned, -2 refers to the two brackets, whereas -4 sets a
    # litle right margin
    local curr_date="$(date +"%T")"
    local abbv_pwd=${PWD//${HOME}/"~"}
    local left_margin="┌─($(whoami)@$(hostname))──[$abbv_pwd]"
    local prefix_aligned="$(printf "%*s\n" $((${COLUMNS}-${#left_margin}-${#curr_date}-2-4)) "")"
    local alignment="${prefix_aligned// /─}[ "

    # Set terminal title bar using PS1
    PS1="${TITLEBAR}"

    # First line prompt
    PS1+="${FG_DARK_GRAY}┌─(${FG_BOLD_CYAN}\u${FG_DARK_GRAY}@${FG_BOLD_CYAN}\h"
    PS1+="${FG_DARK_GRAY})──[${FG_BOLD_CYAN}\w${FG_DARK_GRAY}]${alignment}"
    PS1+="${FG_BOLD_CYAN}${curr_date}${FG_DARK_GRAY} ]\n"

    # Second line prompt
    PS1+="${FG_DARK_GRAY}└─(${STATUS_COLOR}\! \# ${EXIT_STATUS}${FG_DARK_GRAY}) "
    PS1+="${STATUS_COLOR}\$ ${FG_DEFAULT}"

    # Other prompts to set
    PS2='{...} '
    PS4='+ '
}


#######################################
##             FUNCTIONS             ##
#######################################

# Performs both mkdir and then got to this new directory with cd builtin
function mkdircd () {
    mkdir -p "$@" && eval cd "\"\$$#\""
}

# Searches the command given as an argument inside bash history
# and output those entries that match to it
function srchcmd () {
    [ $# -eq 0 ] && echo "Usage: srchcmd [cmd_to_search]" && return 1
    history | grep "$@"
}

# Shows the IP assigned on the given interface
function ifaceip () {
    [ $# -eq 0 ] && echo "Usage: ifaceip [iface]" && return 1
    ifconfig $1 | awk '/inet addr/ {print $2}' | awk -F: '{print $2}'

    # Alternative solution
    # ifconfig $1 | grep "inet addr" | cut -d ':' -f2 | cut -d ' ' -f1
}

# Checks if the given argument is a well formed IP at syntax level
function isanip () {
    if [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] ; then

        local BAK_IFS=$IFS
        IFS='.'
        local ip=($1)
        IFS=$BAK_IFS

        if [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        then
            echo "$1 is a valid IP"
            return 0

        else
            echo "$1 is not a valid IP"
            return 1
        fi

    else
        echo "$1 is not a valid IP"
        return 1
    fi
}

# Resolves domain names to their IPs and viceversa
function dnsres () {
    if [ $# -ne 1 ] ; then
        echo "Usage: dnsres [name_or_IP]"
        return 1
    fi

    local output="$(nslookup $1)"
    local error="$(echo "$output" | grep ^[*][*])"

    [ "x$error" != "x" ] && echo "$error" && return 2

    isanip $1 > /dev/null

    if [ $? -eq 0 ] ; then

        # sed -e 's/.$//' -e 's/^[ \t]*//' removes the last character
        # (special single character '.' in regexp) and all leading 
        # whitespaces, including tabs
        local res="$(echo "$output" | grep name | cut -d '=' -f2 | sed -e 's/.$//' -e 's/^[ \t]*//')"

    else
        local res="$(echo "$output" | grep Address | tail -n 1 | cut -d ':' -f2 | sed -e 's/^[ \t]*//')"
    fi

    echo $res
    return 0
}

# Removes trailing whitespaces for an entire directory.
# It ignores .git an .svn folders and their contents.
function rm_tr_white () {
    find . -not \( -name .svn -prune -o -name .git -prune -o -name '*.a' \) -type f -print0 | xargs -0 sed -i -e "s/[[:space:]]*$//"
}

#######################################
##              ALIASES              ##
#######################################

# User bash aliases are defined in ~/.bash_aliases file
# It's sourced at line 99 of this dotfile

