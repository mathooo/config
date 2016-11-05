#! /bin/bash

sudo add-apt-repository ppa:ricotz/docky && sudo add-apt-repository ppa:ubuntu-toolchain-r/test && sudo add-apt-repository ppa:webupd8team/sublime-text-3 && sudo add-apt-repository ppa:webupd8team/atom && sudo add-apt-repository ppa:gezakovacs/ppa && sudo add-apt-repository ppa:wiznote-team

sudo apt-get update

sudo apt-get install skype chromium-browser gparted htop texlive-full subversion git plank apcalc xournal steam pinta qbittorrent default-jdk openjdk-7-jdk gcc-4.9 nautilus-dropbox wine sublime-text-installer atom unetbootin wiznote python-pip numlockx vim

# Moreover:
# sudo -H pip install thefuck ('pip install psutil' might be needed)
# and replace /etc/bash.bashrc

# Enable Numlock on startup
# sudo gedit /etc/mdm/Init/Default
# and put this inthere:
# if [ -x /usr/bin/numlockx ]; then
# exec /usr/bin/numlockx on
# fi

# Unicode stuff:
# download https://github.com/osense/dotfiles/blob/master/.XCompose
# create .xprofile and put there these lines:
# export GTK_IM_MODULE='xim'
# export QT_IM_MODULE='xim'
