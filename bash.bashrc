# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

/usr/bin/mint-fortune

eval "$(thefuck --alias)"
eval "$(thefuck --alias FUCK)"

# split pdf function: <inputPDF> <pages 5 or 6-9> <outputPDF>
function splitpdf { pdftk "$1" cat "$2" output "$3"; }
export -f splitpdf

# function for building latex PDFs
function buildpdf {
    name=${1::-4}
    echo "*******************"$name"*******************"
    pdflatex $1
    bibtex $name
    pdflatex $1
    pdflatex $1
}
export -f buildpdf

# function for finding files in whole system
function ff {
	export GREP_COLORS="sl=0;0;0:ms=1;31;18"
	find / -name $1 2>/dev/null
}
export -f ff

# fuction for translating text with diacritics to text without them
# it works for text in windows-1250 encoding, this can be changed manually or extended as a parameter
function diacritics {
	cat $1 | iconv -f windows-1250 -t ascii//TRANSLIT//IGNORE > $2
}
export -f diacritics


HUGINHOME=/home/dataSSD/Programs/HUGIN_LITE_64.linux5
export HUGINHOME

# Aliases
alias ll='ls -al'
alias lsal='ls -al'
alias get='sudo apt-get install'
alias untar='tar -zxvf'
alias commit="git commit -m"
alias add="git add"
alias push="git push"
alias pull="git pull"
alias gst="git status"
alias weather="curl wttr.in/brno"
alias visual="python /home/matho/Documents/NetworkVISUAL/create\ graph/create_graph.py"
alias myip="wget http://ipinfo.io/ip -qO -"
alias svncom="svn commit -m \"\""
alias c="calc"
alias hotup="nmcli con up id Hotspot"
alias hotdown="nmcli con down id Hotspot"
alias python="/usr/bin/python2.7"
alias anaconda="/home/matho/miniconda2/bin/python"
alias pipanaconda="/home/matho/miniconda2/bin/pip"
