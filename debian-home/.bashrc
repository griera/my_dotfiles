# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enables color support of ls command.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Enables programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#######################################
##           SHELL OPTIONS           ##
#######################################

# Append to the history file, don't overwrite it
shopt -s histappend

# Correct minor errors in the spelling of a directory component in cd builtin
shopt -s cdspell

# Check the window size after each command and, if necessary, update the value
# of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will match all
# files and zero or more directories and subdirectories.
#shopt -s globstar


#######################################
##           PROMPT SETTING          ##
#######################################

# Set variables which contains color codes definitions.
source ~/.bash_color_codes

# Current selected prompt. It's a two line prompt like this:
#
# ┌─(user@hostname)──[/working_dir (git_branch)]────────[ hh:mm:ss ]
# └─(hist_num_cmd num_cmd exit_status_last_cmd) $
#
# [ hh:mm:ss ] is aligned at top right of terminal.
#
# If working_dir belongs to a git repository, then show the current branch
# which you are on. Also, if the repository has no pending changes, the text
# color will be the same as working_dir text. If not, it will be red.
#
# Second line change the color to red if exit status of last executed command
# differs from 0, otherwise the color is set to green.
#
function set_prompt1 () {

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
        local STATUS_COLOR=$FG_HIGH_INTENSITY_RED
    fi

    # Set git branch color related to pending changes to commit
    local git_ps1="$(__git_ps1)"
    local GIT_STATUS_COLOR=$FG_HIGH_INTENSITY_CYAN
    local git_status="$(git status 2> /dev/null | grep "nothing to commit")"
    if [ "x$git_status" = "x" ] ; then
        GIT_STATUS_COLOR=$FG_HIGH_INTENSITY_RED
    fi

    # Process to align date on top-right corner using terminal width.
    # On prefix_aligned, -2 refers to the two brackets, whereas -4 sets a
    # litle right margin
    local curr_date="$(date +"%T")"
    local abbv_pwd=${PWD//${HOME}/"~"}
    local left_margin="┌─($(whoami)@$(hostname))──[$abbv_pwd$git_ps1]"
    local prefix_aligned="$(printf "%*s\n" $((${COLUMNS}-${#left_margin}-${#curr_date}-2-4))"")"
    local alignment="${prefix_aligned// /─}[ "

    # Set terminal title bar using PS1
    PS1="${TITLEBAR}"

    # First line prompt
    PS1+="${FG_WHITE}┌─(${FG_HIGH_INTENSITY_CYAN}\u${FG_DEFAULT}${FG_WHITE}@${FG_HIGH_INTENSITY_CYAN}\h"
    PS1+="${FG_WHITE})──[${FG_HIGH_INTENSITY_CYAN}\w${FG_DEFAULT}${GIT_STATUS_COLOR}${git_ps1}${FG_WHITE}]${alignment}${FG_DEFAULT}"
    PS1+="${FG_HIGH_INTENSITY_CYAN}${curr_date}${FG_WHITE} ]\n"

    # Second line prompt
    PS1+="${FG_WHITE}└─(${STATUS_COLOR}\! \# ${EXIT_STATUS}${FG_WHITE}) "
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
function hsrch () {
    history | grep "$@"
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
    local output="$(nslookup $1)"
    local error="$(echo "$output" | grep ^[*][*])"

    [ "x$error" != "x" ] && echo "$error" && return 2

    isanip $1 > /dev/null

    if [ $? -eq 0 ] ; then

        # sed -e 's/.$//' -e 's/^[ \t]*//' removes the last character
        # (special single character '.' in regexp) and all leading
        # whitespaces, including tabs
        local res="$(echo "$output" | grep name | cut -d '=' -f2 | sed -e 's/.$//' -e 's/^[\t]*//')"

    else
        local res="$(echo "$output" | grep Address | tail -n 1 | cut -d ':' -f2 | sed -e 's/^[ \t]*//')"
    fi

    echo $res
    return 0
}

# Removes trailing whitespaces for an entire directory.
# It ignores .git an .svn folders and their contents.
function rm_trailw () {
    if [ "x$1" = "x" ] ; then
        path="."
    else
        path="$1"
    fi

    find $path -not \
        \( -name .svn -prune -o -name .git -prune -o -name '*.a' \) \
        -type f -print0 | xargs -0 sed -i -e "s/[[:space:]]*$//"
}

# Small CPU benchmark with PI, bc and time
function cpubench() {
    local CPU="${1:-1}"
    local SCALE="${2:-5000}"
    for LOOP in $(seq 1 $CPU) ; do
        time echo "scale=${SCALE}; 4*a(1)" | bc -l -q | grep -v ^"[0-9]" &
    done
    echo -e "Cores: $CPU\nDigit: $SCALE"
}

# Mount a VMware virtual disk (.vmdk) file
function vmmount() {
    if [ ! -d "/tmp/vmmount" ]; then
        sudo mkdir -p /tmp/vmmount
    fi

    sudo mount $1 /tmp/vmmount/ -o ro,loop=/dev/loop1,offset=32768 -t ntfs
}

# Continuous random string of text
function gen_random_str() {
    while true ; do
        sleep .15
        head /dev/urandom | tr -dc A-Za-z0-9
    done

# git clone all user repos
function gclaur() {
    local user="$1"
    curl -s https://api.github.com/users/$user/repos | \
        jq -r 'map(select(.fork == false)) | map(.url) | map(sub("https://api.github.com/repos/"; "git clone git@github.com:")) | @sh' | xargs -n1 sh -c
}

#######################################
##              ALIASES              ##
#######################################

# cd builtin useful aliases
alias cd1="cd .."
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias cd5="cd ../../../../.."
alias cd6="cd ../../../../../.."
alias cdabs='cd $(pwd -P)'

# shutdown and reboot PC
alias shutdown='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'

# history command useful aliases
alias h1='history 10'
alias h2='history 20'
alias h3='history 30'
alias h4='history 40'
alias h5='history 50'

# apt-get command useful aliases
alias upgrade='sudo apt-get update && sudo apt-get upgrade'
alias purge='sudo apt-get purge'
alias remove='sudo apt-get remove'
alias install='sudo apt-get install'

# Other useful aliases for frequently used commands
alias ls='ls --color=auto'
alias l='ls -lah'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias mount='mount | column -t'
alias du='du -hs'
alias c='clear'
alias x='exit'
alias chrome='google-chrome'
alias rand4='echo $(($RANDOM%4 + 1))'
alias g='git'
alias rslsync='rslsync --storage ~/resilio_sync/.sync'
alias xbindkeys_restart='killall -HUP xbindkeys'
alias dumppayload='sudo tcpdump -nnvvXSs 1514'

# Useful alias for DPDK environment
alias dpdk_nic_bind="sudo ${RTE_SDK}/tools/dpdk_nic_bind.py"
alias dpdk_setup="~/repos/dpdk_training/tools/dpdk_setup.sh"

#######################################
##              OTHERS               ##
#######################################

# Keep the bash completion enabled for git alias
. /usr/share/bash-completion/completions/git
complete -F _git g

# Enable bash-insulter:
# https://github.com/hkbakke/bash-insulter
if [ -f $HOME/bash.command-not-found ]; then
    . $HOME/bash.command-not-found
fi
