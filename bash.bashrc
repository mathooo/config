# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
# but only if not SUDOing and have SUDO_PS1 set; then assume smart user.
if ! [ -n "${SUDO_USER}" -a -n "${SUDO_PS1}" ]; then
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ] ; then
    case " $(groups) " in *\ admin\ *|*\ sudo\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.
	
	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi

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

# function for finding substring inside all files in a directory
function fs {
	for file in `find ./$1 -type f`
	do
	    result=`grep -nr $2 $file` 
	    if [[ $? -eq 0 ]]
	    then
		echo "-----------------------------------------------------"
		echo $file " :"
		echo "$result"
		echo
	    fi
	done
}
export -f fs

# fuction for translating text with diacritics to text without them
# it works for text in windows-1250 encoding, this can be changed manually or extended as a parameter
function diacritics {
	cat "$1" | iconv -f windows-1250 -t ascii//TRANSLIT//IGNORE > tmp.srt
	cp tmp.srt "$1"
	rm tmp.srt
}
export -f diacritics

# Aliases
alias get='sudo apt-get install'
alias untar='tar -zxvf'
alias commit="git commit -m"
alias add="git add"
alias push="git push"
alias pull="git pull"
alias gst="git status"
alias c="calc"
alias printFI="python3 /home/matho/Documents/GITs/config/printFI.py"
