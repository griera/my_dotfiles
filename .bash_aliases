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
alias lsfuncs="grep ^function ~/.bashrc | cut -d ' ' -f2"

# Useful aliases related to LibreOffice suite
alias writerlo='libreoffice --writer'
alias calclo='libreoffice --calc'
alias drawlo='libreoffice --draw'
alias mathlo='libreoffice --math'
alias baselo='libreoffice --base'
alias impresslo='libreoffice --impress'
alias weblo='libreoffice --web'

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

# Useful aliases for frequently used commands
alias clr='clear'
alias x='exit'
alias chrome='google-chrome'

