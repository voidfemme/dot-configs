#-----------------------------------
# Source global definitions (if any)
#-----------------------------------

if [ -f /etc/bashrc ]; then
	. /etc/bashrc 	# --> Read /etc/bashrc, if present
fi

#---------------
# Some settings
#---------------

export TERM=xterm-256color
export EDITOR=nvim
export VISUAL=nvim
ulimit -S -c 0
set -o notify
set -o noclobber
set -o ignoreeof
set -o nounset
#set -o xtrace 		# useful for debugging


#-----------------------
# Greeting, motd etc...
#-----------------------

#--------------
# Shell Prompt
#--------------

bold=$(tput bold)
normal=$(tput sgr0)
var1='\e[1m'
red='\e[34;2;205;91;91m'
yellow='\e[34;2;205;91;93m'
green='\e[34;2;205;91;92m'
blue='\e[34;2;205;91;94m'
purple='\e[34;2;205;91;95m'
varz='\]'

# PS1="\[\e[1m\e[34;2;205;91;91m\](\u) \w >\[\e[0m\] "
# PS2="\[\e[1m\e[34;2;205;91;91m\]\\>\[\e[0m\] "
#PS1="${bold}${red}(${yellow}\u${green})${varz} ${blue}\w ${purple}$\[\e[0m\]${normal} "

~/.config/myscripts/./newtermwindow.sh
source ~/.aliasrc.sh
