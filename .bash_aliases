#######################################
##              ALIASES              ##
#######################################

# Useful griera bash aliases must be defined in this dotfile

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
alias rebootnow='sudo shutdown -r now'

# list all functions defined by myself on ~/.bashrc
alias lsusrfuncs="grep ^function ~/.bashrc | cut -d ' ' -f2 | sort"

# history command useful aliases
alias h1='history 10'
alias h2='history 20'
alias h3='history 30'
alias h4='history 40'
alias h5='history 50'

# mount command useful aliases
alias mount='mount | column -t'

# apt-get * commands useful aliases
alias update='sudo apt-get update && sudo apt-get upgrade'
alias purge='sudo apt-get purge'
alias remove='sudo apt-get remove'

# Useful aliases for onePK VM's
#alias run-onepk-vm-1.0='vmplayer ~/vmware/onepk-all-in-one-CA-20130611/onepk-all-in-one-CA-20130611.vmx'
alias run-onepk-vm='vmplayer ~/vmware/onepk-all-in-one-VM-1.3.0.181/onepk-all-in-one-VM-1.3.0.181.vmx'

# Useful aliases for frequently used commands
alias clr='clear'
alias x='exit'
alias chrome='google-chrome'
alias run-so2-vm='vmplayer ~/my_links/SO2/Ubuntu-Proso-2009/Ubuntu.vmx'
alias dw-onepk='scp onepk_vm:*_onepk_configs_and_codes.tar.gz ~/my_links/NetIT_Lab/onePK/ && scp ~/my_links/NetIT_Lab/onePK/*_onepk_configs_and_codes.tar.gz netit-desktop:onePK/'
alias up-zeos='rsync -vzr --exclude=.git ~/repos/zeos/* so2-vm:~/zeos/.'
alias dw-zeos='rsync -vzr --exclude=libjp.a so2-vm:~/zeos/* ~/repos/zeos/.'
alias lsla='ls -la'
alias dbox-rst='dropbox stop && dropbox start'
alias dbox-stp='dropbox stop'
alias dbox-str='dropbox start'
alias dbox-st='dropbox status'
alias rand4='echo $(($RANDOM%4 + 1))'
alias g='git'
alias gcal="${HOME}/repos/gcalcli/gcalcli"
alias btsync="${HOME}/bittorrent_sync/btsync --config ~/bittorrent_sync/btsync.config"
